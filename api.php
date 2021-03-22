<?php
// Every output is planed to be a json string
header('Content-Type: application/json');

/**
 * This function will get the options received by GET and will return the structured json
 * @param int $node_id Id of the node I want to retreive
 * @param string $language value of the language in wich I will receive the nodeNames
 * @param string $search_keyword Optional search string to look up on the nodeName
 * @param int $page_num Optional page number
 * @param int $page_size Optional page size
 */
function getNodes($node_id, $language, $search_keyword = null, $page_num = null, $page_size = null)
{
    // bring up our config file and set up the DB connection with the its charset
    require_once('config.php');
    $DB = new mysqli($host, $user, $pass, $dbname);
    if ($DB->connect_error) {
        throw new Exception('Error connecting to database');
    }
    $DB->set_charset("utf8mb4");

    // Initialize the variables
    $bind_types = "";  // concat all the binding types, eg.: 'sss'
    $bind_elements = []; // all the values to bind for each type
    $langs_placeholders = []; // adds the placeholders for the lang part of the statement
    $search_stmt = ""; // initialize with an empty limit statement. For pagination purposes.
    $limit_stmt = ""; // initialize with an empty limit statement. For pagination purposes.

    try {
        // exit with an error if page size is invalid
        if (intval($page_num) < 0) {
            throw new Exception("Invalid page size requested");
        }

        // check for page_num value, if not defined or empty, set 0 as default
        $page_num = ($page_num !== "" && !is_null($page_num))
            ? $page_num
            : "0";

        // exit with an error if page size is invalid
        if (intval($page_size) > 1000 || intval($page_size) < 0) {
            throw new Exception("Invalid page size requested");
        }

        // same for page_size value, if not defined or empty, set 1000 as default
        $page_size = ($page_size !== "" && !is_null($page_size))
            ? $page_size
            : "100";
        //quicly check if the given node exists
        $check_stmt = $DB->prepare("SELECT idNode FROM node_tree WHERE idNode = ?");
        $check_stmt->bind_param("s", $node_id);
        $check_stmt->execute();
        $check_result = $check_stmt->get_result();
        if (!$check_result->num_rows) {
            throw new Exception("Invalid node id");
        }
        // if the node param exists set the first binding, otherwise throws an error
        if ($node_id) {
            $bind_types .= "s";
            $bind_elements[] = $node_id;
        } else {
            throw new Exception("Missing mandatory params");
        }
        //if empty throws an error, then iterates the langs and add a bind for each one
        if (!$language) {
            throw new Exception("Missing mandatory params");
        }
        $langs = explode(",", $language);
        foreach ($langs as $lang) {
            $langs_placeholders[]= "?";
            $bind_types .= "s";
            $bind_elements[] = trim($lang);
        }
        // if a search keyword is set add it to the binding auxiliary variables
        if ($search_keyword) {
            $bind_types .= "s";
            $bind_elements[] = "%" . trim($search_keyword) . "%";
            $search_stmt = " AND node_names.nodeName LIKE ? ";
        }

        // build the limit statement for the pagination
        $offset = $page_num * $page_size;
        $limit_stmt = " LIMIT " . $page_size . " OFFSET " . $offset;

        // Build the query to get the children for the given parent node
        // at the end we add the statement parts for languages, search and pagination
        $nodes_query = "SELECT children.*, node_names.nodeName
            FROM node_tree parent
            JOIN node_tree children ON children.iLeft
                BETWEEN parent.iLeft AND parent.iRight
            JOIN node_tree_names node_names ON children.idNode=node_names.idNode
            WHERE parent.idNode = ?
                AND node_names.language IN (" . implode(',', $langs_placeholders) . ") "
                . $search_stmt
                . $limit_stmt;

        // Prepare the statement and bind with the built types and values
        $stmt = $DB->prepare($nodes_query);
        $stmt->bind_param($bind_types, ...$bind_elements);
        $stmt->execute();
        $result = $stmt->get_result();

        $nodes=[];
        // iterates the result rows and put them in an array to then output as a JSON
        if ($result->num_rows) {
            while ($row = $result->fetch_assoc()) {
                $nodes["nodes"][] = $row;
            }
            if (count($nodes) > 0) {
                http_response_code(200);
                echo json_encode($nodes);
            }
        } else {
            // if the result is empty, return a 404 with the empty array
            http_response_code(404);
            $nodes["error"] = "No nodes found with the given parameters";
            echo json_encode($nodes);
        }

        $stmt->close();
    } catch (Exception $e) {
        // for every error we return a bad request with the error message
        http_response_code(400);
        echo json_encode(["error" => $e->getMessage()]);
    }
}

// run the function
getNodes(
    $_GET['node_id'],
    $_GET['language'],
    $_GET['search_keyword'],
    $_GET['page_num'],
    $_GET['page_size']
);
exit;

-- ----------------------------
-- Records of node_tree
-- ----------------------------
BEGIN;
INSERT INTO `node_tree` VALUES (1, 2, 2, 3);
INSERT INTO `node_tree` VALUES (2, 2, 4, 5);
INSERT INTO `node_tree` VALUES (3, 2, 6, 7);
INSERT INTO `node_tree` VALUES (4, 2, 8, 9);
INSERT INTO `node_tree` VALUES (5, 1, 1, 24);
INSERT INTO `node_tree` VALUES (6, 2, 10, 11);
INSERT INTO `node_tree` VALUES (7, 2, 12, 19);
INSERT INTO `node_tree` VALUES (8, 3, 15, 16);
INSERT INTO `node_tree` VALUES (9, 3, 17, 18);
INSERT INTO `node_tree` VALUES (10, 2, 20, 21);
INSERT INTO `node_tree` VALUES (11, 3, 13, 14);
INSERT INTO `node_tree` VALUES (12, 2, 22, 23);
COMMIT;

-- ----------------------------
-- Records of node_tree_names
-- ----------------------------
BEGIN;
INSERT INTO `node_tree_names` VALUES (1, 1, 'english', 'Marketing');
INSERT INTO `node_tree_names` VALUES (2, 1, 'italian', 'Marketing');
INSERT INTO `node_tree_names` VALUES (3, 2, 'english', 'Helpdesk');
INSERT INTO `node_tree_names` VALUES (4, 2, 'italian', 'Supporto tecnico');
INSERT INTO `node_tree_names` VALUES (5, 3, 'english', 'Managers');
INSERT INTO `node_tree_names` VALUES (6, 3, 'italian', 'Managers');
INSERT INTO `node_tree_names` VALUES (7, 4, 'english', 'Customer Account');
INSERT INTO `node_tree_names` VALUES (8, 4, 'italian', 'Assitenza Cliente');
INSERT INTO `node_tree_names` VALUES (9, 5, 'english', 'Docebo');
INSERT INTO `node_tree_names` VALUES (10, 5, 'italian', 'Docebo');
INSERT INTO `node_tree_names` VALUES (11, 6, 'english', 'Accounting');
INSERT INTO `node_tree_names` VALUES (12, 6, 'italian', 'Amministrazione');
INSERT INTO `node_tree_names` VALUES (13, 7, 'english', 'Sales');
INSERT INTO `node_tree_names` VALUES (14, 7, 'italian', 'Supporto vendite');
INSERT INTO `node_tree_names` VALUES (15, 8, 'english', 'Italy');
INSERT INTO `node_tree_names` VALUES (16, 8, 'italian', 'Italia');
INSERT INTO `node_tree_names` VALUES (17, 9, 'english', 'Europe');
INSERT INTO `node_tree_names` VALUES (18, 9, 'italian', 'Europa');
INSERT INTO `node_tree_names` VALUES (19, 10, 'english', 'Developers');
INSERT INTO `node_tree_names` VALUES (20, 10, 'italian', 'Sviluppatori');
INSERT INTO `node_tree_names` VALUES (21, 11, 'english', 'North America');
INSERT INTO `node_tree_names` VALUES (22, 11, 'italian', 'Nord America');
INSERT INTO `node_tree_names` VALUES (23, 12, 'english', 'Quality Assurance');
INSERT INTO `node_tree_names` VALUES (24, 12, 'italian', 'Controllo Qualità');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for node_tree
-- ----------------------------
DROP TABLE IF EXISTS `node_tree`;
CREATE TABLE `node_tree` (
  `idNode` int(11) NOT NULL AUTO_INCREMENT,
  `level` int(11) NOT NULL,
  `iLeft` int(11) NOT NULL,
  `iRight` int(11) NOT NULL,
  PRIMARY KEY (`idNode`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for node_tree_names
-- ----------------------------
DROP TABLE IF EXISTS `node_tree_names`;
CREATE TABLE `node_tree_names` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idNode` int(11) NOT NULL,
  `language` varchar(50) NOT NULL,
  `nodeName` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idNode` (`idNode`),
  CONSTRAINT `idNode` FOREIGN KEY (`idNode`) REFERENCES `node_tree` (`idNode`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;

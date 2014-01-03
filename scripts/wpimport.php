<?php
/**
 * @author Ruud Bijnen <mail@ruudbijnen.nl>
 * @copyright Copyright (c) 2013, Ruud Bijnen
 */

define('DS', DIRECTORY_SEPARATOR);

$db = new PDO('mysql:host=localhost;dbname=wpbackup;charset=utf8', 'rbscript', 'rbscript');
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

$postTypeMap = array(
	'post' => 'blog',
	'portfolio' => 'projects'
);

foreach ($db->query("SELECT * FROM `wp_posts` WHERE `post_status`='publish' AND `post_type` IN('post', 'portfolio');") as $row) {

	$tags = array('old-content' => 'Old Content');
	$categories = array('old-content' => 'Old Content');
	$id = $row['ID'];
	$termStmt = $db->query(
		"SELECT * FROM `wp_term_relationships`
			LEFT JOIN `wp_term_taxonomy` ON (wp_term_relationships.term_taxonomy_id = wp_term_taxonomy.term_taxonomy_id)
			LEFT JOIN `wp_terms` ON (wp_terms.term_id = wp_term_taxonomy.term_id)
			WHERE object_id = {$id};");

	foreach ($termStmt as $term) {
		switch ($term['taxonomy']) {
			case 'post_tag':
				$tags[$term['slug']] = $term['name'];
				break;
			case 'category':
				$categories[$term['slug']] = $term['name'];
				break;
			default:
				break;
		}
	}

	$data  = '---' . PHP_EOL;
	$data .= 'title: ' . $row['post_title'] . PHP_EOL;
	$data .= 'date: ' . $row['post_date_gmt'] . PHP_EOL;
	//$data .= 'layout: blog-post' . PHP_EOL;
	$data .= 'tags: [' . implode(', ', array_keys($tags)) . ']' . PHP_EOL;
	$data .= 'categories: [' . implode(', ', $categories) . ']' . PHP_EOL;
	$data .= '---' . PHP_EOL;

	$data .= "<p>" . str_replace("\r\n\r\n", "</p>\r\n<p>", trim($row['post_content'])) . "</p>\r\n";

	$data .= PHP_EOL;
	$filename = $row['post_name'] . '.html';
	file_put_contents( 'src'.DS.'documents'.DS. $postTypeMap[$row['post_type']] .DS . $filename, $data);
}
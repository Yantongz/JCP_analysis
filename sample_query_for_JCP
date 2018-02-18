
WITH both_emails AS (
                       SELECT *
                       FROM first_emails
                       UNION
                       SELECT *
                       FROM second_emails
)

SELECT  COUNT(*) AS Total
FROM both_emails

JOIN authors, institutions, affiliations, reply_codes, groups, article_groups, corresponding_author_articles
ON 	authors.author_id = both_emails.author_id AND
institutions.institution_id = authors.institution_id AND
affiliations.affiliation_id = institutions.affiliation_id AND
reply_codes.reply_code_id = both_emails.reply_code_id AND
groups.group_id = article_groups.group_id AND
article_groups.article_id = corresponding_author_articles.article_id AND
corresponding_author_articles.author_id = authors.author_id

WHERE affiliations.affiliation_name = "Academic" AND groups.group_name = "Informed" AND
( reply_code_name = "Shared Partial data and code" OR reply_code_name = "Shared data and code") ;

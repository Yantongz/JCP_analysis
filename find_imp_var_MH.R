print("We are trying to determine significant variables to put into our model.")

print("Using the Cochran-Mantel-Haenszel method to produce a single, summary measure of association, which provides a weighted average of the  odds ratio across the different strata of the confounding factor.")
print("i.e., a stratified analysis, test the association between a binary predictor or treatment and a binary outcome while taking into account the stratification.")

print("This method is for testing the following features: ")
print("affiliations/ gender/ institution / article_codes (pre-email conditions) /web-presence / tenure (manually assign 3 categories), predictors with no more than 3 categories.")

library("RSQLite")
con = dbConnect(RSQLite::SQLite(), dbname="C:\\Users\\yantongz\\Desktop\\JCP\\Anonymized_JCP.db")


# naming skeme: stratum_In(formed)/Un(informed)_sh(are)/not_sh(are)

aca_in_sh = dbGetQuery(con, '
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
                       ( reply_code_name = "Shared Partial data and code" OR
                       reply_code_name = "Shared data and code") ;')



# gives me an error if I don't have ".db" at the end of file path
# Error in rsqlite_send_query(conn@ptr, statement) : no such table: authors
# but somehow without ".db" it still reads in the global environment with no eror msg

# calculate the odds ratio:

# aca_OR = (aca_in_sh/aca_in_not_sh)/(aca_un_sh/aca_un_not_sh)


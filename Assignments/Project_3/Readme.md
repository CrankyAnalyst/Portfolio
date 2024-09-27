Overview - Exploring Taxonomies and Data Matching Techniques

When I got this assignment about taxonomies, I wasn’t too familiar with the concept at first. It wasn’t mandatory to complete, but I wanted to explore it to better understand why it’s important and what I could learn from it. The idea of mapping different taxonomies seemed challenging, but it also felt like a great opportunity to dive deeper into data analysis tools like SQL and Excel.

What are taxonomies?

I had to start by learning what taxonomies really mean in this context. Basically, they’re a way to organize data into categories and subcategories, kind of like how a library organizes books into sections. In this case, there were two different taxonomies: one belonging to the company, and the other from a client. The task was to find a way to map these two sets of categories together, even though they used slightly different names and structures.

For example:

Category A in Taxonomy1 might map to Category B in Taxonomy2.
But sometimes, it wasn’t so simple. A single category from Taxonomy1 might map to multiple categories in Taxonomy2, or only a part of a category.
Exploring Similarity Matching:
Since this wasn’t about cleaning or merging data, my goal was to analyze the relationships between these two taxonomies. One of the main techniques I came across was similarity matching, which helps measure how closely two text strings (in this case, the category names) match each other.

I decided to approach this in two different ways:

SQL (PostgreSQL):

SQL has a function called similarity(), which gives you a score based on how similar two pieces of text are. I ran this function on each pair of categories from Taxonomy1 and Taxonomy2 to see how well they matched.
I learned that a score of 1 means a perfect match (the categories are identical), while a score closer to 0 means the categories are very different.

Results:
After running the query, I found out that most categories had a score below 0.7, meaning they were not very similar. Only about 670 out of 34,264 pairs had scores over 0.7, which suggested those were pretty good matches.

Excel and the Fuzzy Lookup Add-On:

I also explored Excel with the Fuzzy Lookup Add-On. While I’m more comfortable with Excel for basic tasks, using Fuzzy Lookup felt like an interesting way to compare text strings directly in Excel. The add-on helps you find matches between two columns of data that aren’t exact, which was helpful for mapping the taxonomies.

Comparison with SQL:

While the Fuzzy Lookup tool worked, it was much slower than SQL for larger datasets. SQL processed the data much faster, but the Excel add-on provided a more visual way to see and adjust matches. It felt more interactive, but for large data like this, it wasn’t as efficient.

What I Learned:

This exercise taught me a few things about data matching and taxonomy mapping:
Understanding why taxonomy mapping is needed: I realized that the reason this task was important is because different systems often organize data in slightly different ways. To make that data useful across systems, you need to map those categories together, which is what this exercise was about.

Similarity scores are subjective: A score of 1 is easy to interpret—categories are exactly the same. But anything lower required more judgment. For example, a score of 0.8 might still represent a good match, even if the names weren’t identical.

Different tools for different needs: While SQL was more powerful for this type of large-scale matching, Excel is still a great tool when you need to do smaller, more visual analysis. Both have their place depending on the task.

Next Steps:

Since this project was just an exploration, I didn’t go as far as actually cleaning or merging the taxonomies, but here’s what I would focus on next if I were to continue:

Refining the matching rules: For those pairs that didn’t have high similarity scores, I’d look closer at whether they should be mapped together. This might involve more manual review.
Handling edge cases: Sometimes, one category in Taxonomy1 maps to multiple categories in Taxonomy2. I didn’t fully explore this, but it’s something to consider in a more detailed analysis.
Exploring Python: I didn’t use Python for this task, but I’ve read that it’s also a powerful tool for text matching and could be another way to handle these large datasets.

Conclusion:

Even though this wasn’t a mandatory project, I’m glad I took the time to dive into it. It helped me understand the importance of taxonomy mapping and gave me the chance to learn how different tools handle data matching. I now have a better grasp of how to approach such tasks in the future, and I’m excited to keep learning and improving my skills with SQL, Excel, and maybe Python next.

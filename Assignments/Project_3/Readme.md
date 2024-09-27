Overview - Exploring Taxonomies and Data Matching

When I got this assignment about taxonomies, I didn’t know much about them. It wasn’t a required task, but I wanted to try it out to understand why it’s important and to learn something new. Mapping different taxonomies seemed a bit tricky, but it was a good chance to use tools like SQL and Excel.

What are Taxonomies?

I had to start by figuring out what taxonomies meant. Basically, they organize data into different categories, like sorting books into sections in a library. For this task, there were two taxonomies: one from my company and the other from the client. The job was to match these categories, even though they were named a bit differently.

For example:
Category A in Taxonomy1 might match Category B in Taxonomy2.
But sometimes, one category from Taxonomy1 might match several categories in Taxonomy2, or only part of it.

Exploring Similarity Matching

This task wasn’t about cleaning or merging the data, but more about checking how similar the two taxonomies were. One main thing I used was similarity matching, which helps measure how close two pieces of text are (in this case, the category names).

I used two methods for this:

1. SQL (PostgreSQL):

In SQL, there’s a function called similarity(). It gives a score from 0 to 1. If it’s 1, the categories are exactly the same. A score closer to 0 means they’re very different.
Most of the category pairs had a score below 0.7, meaning they weren’t very similar. Only about 670 out of 34,000 pairs had a score over 0.7, which meant they were better matches.

2. Excel with Fuzzy Lookup Add-On:

I also tried the Fuzzy Lookup add-on in Excel. This tool helps find matches between two columns, even if the data isn’t exactly the same. It was interesting to use but much slower than SQL for large datasets.

While SQL was faster, the Excel add-on felt more visual and easier to adjust manually, but it wasn’t great for large amounts of data.

What I Learned

Why mapping is needed: Different systems organize their data in different ways, so mapping them together is necessary to make them useful across systems.
Similarity scores need interpretation: A score of 1 is easy to understand—categories are the same. But lower scores, like 0.8, might still represent a good match, even if the names aren’t identical.

Choosing the right tool: SQL is great for handling large datasets quickly, while Excel is good for more visual, smaller tasks. Both have their uses depending on what you're doing.

Next Steps

Since this was just an exploration, I didn’t clean or merge the taxonomies yet, but here’s what I’d focus on next:

Refining matching rules: For pairs that don’t have high similarity scores, I’d manually check if they should still be matched.
Handling tricky cases: Sometimes, one category in Taxonomy1 maps to several categories in Taxonomy2. I’d look more into these.
Trying out Python: I didn’t use Python for this task, but I know it’s another powerful tool for working with large datasets and might be something I’ll explore in the future.

Conclusion

Even though this project wasn’t required, I’m glad I tried it. It helped me understand the importance of taxonomy mapping and gave me the chance to see how different tools work with data matching. I’m looking forward to continuing to improve my skills with SQL, Excel, and maybe trying out Python next.

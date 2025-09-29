# Task 1

# 1. Copy original dataframe into a new one: my_mtcars
my_mtcars <- mtcars

# 2. Investigate my_mtcars using str function
str(my_mtcars)
# The mtcars dataset has 32 observations (rows) and 11 variables (columns)

# 3. Calculate engine displacement per cylinder and save it as a new variable 'UnitEngine'
my_mtcars$UnitEngine <- my_mtcars$disp / my_mtcars$cyl

# 4. Summarize the new variable 'UnitEngine'
summary(my_mtcars$UnitEngine)

# ---------------------------------------------------

# Task 2

# 5. Create a numeric vector 'Pets' with these numbers (1,1,1,0,0)
Pets <- c(1, 1, 1, 0, 0)

# 6. Create a numeric vector 'Order' with these numbers (3,1,2,3,3)
Order <- c(3, 1, 2, 3, 3)

# 7. Create a numeric vector 'Siblings'
Siblings <- c(0, 3, 5, 0, 0)

# 8. Create a numeric vector 'IDs'
IDs <- c(1, 2, 3, 4, 5)

# 9. Combine those four numeric vectors together into a dataframe called 'myFriends'
myFriends <- data.frame(IDs, Pets, Order, Siblings)

# 10. Report the structure of the dataframe
str(myFriends)

# 11. Summarize the dataframe
summary(myFriends)

# 12. List (print) all of the values for 'IDs' variable in the dataframe
myFriends$IDs

# 13. List all of the values for 'Pets' variable in the dataframe
myFriends$Pets

# 14. List all of the values for 'Order' variable in the dataframe
myFriends$Order

# 15. List all of the values for 'Siblings' variable in the dataframe
myFriends$Siblings

# 16. Write a code to print the values in the fifth observation of the Pets variable
myFriends$Pets[5]

# 17. Add a vector called 'age' to 'myFriends' using cbind function
age <- c(23, 21, 45, 21, 18)
myFriends <- cbind(myFriends, age)

# 18. Define a vector called 'names' by including all the names in a vector
names <- c("John", "Smith", "Susan", "Joe", "Wendy")

# 19. Add a vector 'names' to 'myFriends' using cbind function
myFriends <- cbind(myFriends, names)

# 20. Print the structure of 'myFriends'
str(myFriends)

# 21. What is NOT the data type (among: factor, numeric, logical, string) of the 'names'?
# The 'names' column is of type 'character' (string). It is NOT a factor, numeric, or logical.


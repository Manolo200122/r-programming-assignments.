# Create matrices
A <- matrix(1:100, nrow = 10)
B <- matrix(1:1000, nrow = 10)

# Check dimensions
cat("Dimensions of A:", dim(A), "\n")
cat("Dimensions of B:", dim(B), "\n")

# For A (square matrix)
if (nrow(A) == ncol(A)) {
  detA <- det(A)
  cat("Determinant of A:", detA, "\n")
  if (abs(detA) < 1e-8) {
    cat("A is singular (determinant is zero), so it can't be inverted.\n")
    invA <- "Error: Matrix is singular."
  } else {
    invA <- solve(A)
    cat("Inverse of A calculated.\n")
  }
} else {
  cat("A is not square, can't compute determinant or inverse.\n")
  detA <- "Error: Not square."
  invA <- "Error: Not square."
}

# For B (not square)
if (nrow(B) == ncol(B)) {
  detB <- det(B)
  invB <- solve(B)
} else {
  cat("B is not square, can't compute determinant or inverse.\n")
  detB <- "Error: Not square."
  invB <- "Error: Not square."
}

# Print results
cat("\nResults for A:\n")
print(invA)
print(detA)
cat("\nResults for B:\n")
print(invB)
print(detB)

Output: 

> # Create matrices
> A <- matrix(1:100, nrow = 10)
> B <- matrix(1:1000, nrow = 10)
> 
> # Check dimensions
> cat("Dimensions of A:", dim(A), "\n")
Dimensions of A: 10 10 
> cat("Dimensions of B:", dim(B), "\n")
Dimensions of B: 10 100 
> 
> # For A (square matrix)
> if (nrow(A) == ncol(A)) {
+   detA <- det(A)
+   cat("Determinant of A:", detA, "\n")
+   if (abs(detA) < 1e-8) {
+     cat("A is singular (determinant is zero), so it can't be inverted.\n")
+     invA <- "Error: Matrix is singular."
+   } else {
+     invA <- solve(A)
+     cat("Inverse of A calculated.\n")
+   }
+ } else {
+   cat("A is not square, can't compute determinant or inverse.\n")
+   detA <- "Error: Not square."
+   invA <- "Error: Not square."
+ }
Determinant of A: 0 
A is singular (determinant is zero), so it can't be inverted.
> 
> # For B (not square)
> if (nrow(B) == ncol(B)) {
+   detB <- det(B)
+   invB <- solve(B)
+ } else {
+   cat("B is not square, can't compute determinant or inverse.\n")
+   detB <- "Error: Not square."
+   invB <- "Error: Not square."
+ }
B is not square, can't compute determinant or inverse.
> 
> # Print results
> cat("\nResults for A:\n")

Results for A:
> print(invA)
[1] "Error: Matrix is singular."
> print(detA)
[1] 0
> cat("\nResults for B:\n")

Results for B:
> print(invB)
[1] "Error: Not square."
> print(detB)
[1] "Error: Not square."


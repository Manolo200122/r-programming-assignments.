# Assuming you have a function tukey.outlier (commonly defined to detect Tukey outliers in a vector; let’s pretend it’s available):
set.seed(123)
test_mat <- matrix(rnorm(50), nrow = 10)

# Provided buggy function:
tukey_multiple <- function(x) {
  outliers <- array(TRUE, dim = dim(x))
  for (j in 1:ncol(x)) {
    outliers[, j] <- outliers[, j] && tukey.outlier(x[, j])
  }
  outlier.vec <- vector("logical", length = nrow(x))
  for (i in 1:nrow(x)) {
    outlier.vec[i] <- all(outliers[i, ])
  }
  return(outlier.vec)
}

# Running it (will error if tukey.outlier exists)
tukey_multiple(test_mat)

# Typical error message as seen in console
# Error in outliers[, j] && tukey.outlier(x[, j]) : 
 # 'length = 10' in coercion to 'logical(1)'
# Diagnose the Bug
# Fix the Code
#Replace && with & for elementwise AND

# Example tukey.outlier function
tukey.outlier <- function(x) {
  qnt <- quantile(x, probs = c(0.25, 0.75), na.rm = TRUE)
  H <- 1.5 * IQR(x, na.rm = TRUE)
  x < (qnt[1] - H) | x > (qnt[2] + H)
}

corrected_tukey <- function(x) {
  stopifnot(is.matrix(x), is.numeric(x))
  outliers <- array(TRUE, dim = dim(x))
  for (j in seq_len(ncol(x))) {
    outliers[, j] <- outliers[, j] & tukey.outlier(x[, j])
  }
  outlier.vec <- logical(nrow(x))
  for (i in seq_len(nrow(x))) {
    outlier.vec[i] <- all(outliers[i, ])
  }
  outlier.vec
}

#  Validate the Fix
set.seed(123)
test_mat <- matrix(rnorm(50), nrow = 10)
corrected_tukey(test_mat)
# Should return a logical vector like:
# [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE

#Defensive Enhancements
set.seed(123)
test_mat <- matrix(rnorm(50), nrow = 10)

robust_tukey <- function(x) {
  if (!is.matrix(x) || !is.numeric(x))
    stop("Input x must be a numeric matrix")
  tukey.outlier <- function(x) {
    qnt <- quantile(x, probs = c(0.25, 0.75), na.rm = TRUE)
    H <- 1.5 * IQR(x, na.rm = TRUE)
    x < (qnt[1] - H) | x > (qnt[2] + H)
  }
  outliers <- array(TRUE, dim = dim(x))
  for (j in seq_len(ncol(x))) {
    outliers[, j] <- outliers[, j] & tukey.outlier(x[, j])
  }
  outlier.vec <- logical(nrow(x))
  for (i in seq_len(nrow(x))) {
    outlier.vec[i] <- all(outliers[i, ])
  }
  outlier.vec
}

print(robust_tukey(test_mat))

OUTPUT CONSOLE:
> set.seed(123)
> test_mat <- matrix(rnorm(50), nrow = 10)
> 
> # Provided buggy function:
> tukey_multiple <- function(x) {
+   outliers <- array(TRUE, dim = dim(x))
+   for (j in 1:ncol(x)) {
+     outliers[, j] <- outliers[, j] && tukey.outlier(x[, j])
+   }
+   outlier.vec <- vector("logical", length = nrow(x))
+   for (i in 1:nrow(x)) {
+     outlier.vec[i] <- all(outliers[i, ])
+   }
+   return(outlier.vec)
+ }
> 
> # Running it (will error if tukey.outlier exists)
> tukey_multiple(test_mat)
Error in outliers[, j] && tukey.outlier(x[, j]) : 
  'length = 10' in coercion to 'logical(1)'

> tukey.outlier <- function(x) {
+   qnt <- quantile(x, probs = c(0.25, 0.75), na.rm = TRUE)
+   H <- 1.5 * IQR(x, na.rm = TRUE)
+   x < (qnt[1] - H) | x > (qnt[2] + H)
+ }
> 
> corrected_tukey <- function(x) {
+   stopifnot(is.matrix(x), is.numeric(x))
+   outliers <- array(TRUE, dim = dim(x))
+   for (j in seq_len(ncol(x))) {
+     outliers[, j] <- outliers[, j] & tukey.outlier(x[, j])
+   }
+   outlier.vec <- logical(nrow(x))
+   for (i in seq_len(nrow(x))) {
+     outlier.vec[i] <- all(outliers[i, ])
+   }
+   outlier.vec
+ }
> set.seed(123)
> test_mat <- matrix(rnorm(50), nrow = 10)
> corrected_tukey(test_mat)
 [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
> robust_tukey <- function(x) {
+   if (!is.matrix(x) || !is.numeric(x))
+     stop("Input x must be a numeric matrix")
+   outliers <- array(TRUE, dim = dim(x))
+   for (j in seq_len(ncol(x))) {
+     outliers[, j] <- outliers[, j] & tukey.outlier(x[, j])
+   }
+   outlier.vec <- logical(nrow(x))
+   for (i in seq_len(nrow(x))) {
+     outlier.vec[i] <- all(outliers[i, ])
+   }
+   outlier.vec
+ }
> set.seed(123)
> test_mat <- matrix(rnorm(50), nrow = 10)
> 
> robust_tukey <- function(x) {
+   if (!is.matrix(x) || !is.numeric(x))
+     stop("Input x must be a numeric matrix")
+   tukey.outlier <- function(x) {
+     qnt <- quantile(x, probs = c(0.25, 0.75), na.rm = TRUE)
+     H <- 1.5 * IQR(x, na.rm = TRUE)
+     x < (qnt[1] - H) | x > (qnt[2] + H)
+   }
+   outliers <- array(TRUE, dim = dim(x))
+   for (j in seq_len(ncol(x))) {
+     outliers[, j] <- outliers[, j] & tukey.outlier(x[, j])
+   }
+   outlier.vec <- logical(nrow(x))
+   for (i in seq_len(nrow(x))) {
+     outlier.vec[i] <- all(outliers[i, ])
+   }
+   outlier.vec
+ }
> 
> print(robust_tukey(test_mat))
 [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE

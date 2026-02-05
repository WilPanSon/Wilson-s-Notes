import cvxpy as cp
import numpy as np
import matplotlib.pyplot as plt

#Part 1
data = np.loadtxt('S26 10-725 HW1 Student Version/Q5a_code/xy_train.csv', delimiter=',')
n = 200
p = 2
X = data[:, 0:2] 
y = data[:, 2]   
C = 1.0
beta  = cp.Variable(p)
beta0 = cp.Variable()
xi = cp.Variable(n)
objective = cp.Minimize(0.5 * cp.sum_squares(beta) + C * cp.sum(xi))
constraints = [
    xi >= 0,
    cp.multiply(y, X @ beta + beta0) >= 1 - xi
]
prob = cp.Problem(objective, constraints)
prob.solve()

print("Status:", prob.status)
print(f"Optimal Criterion Value: {prob.value:.4f}")
print("Optimal Coefficients (beta):", beta.value)
print(f"Optimal Intercept (beta0): {beta0.value:.4f}")

b_val = beta.value   
b0_val = beta0.value   

idx_pos = (y == 1)
idx_neg = (y == -1)

#Part 2
plt.figure(figsize=(8, 6))

plt.scatter(X[idx_pos, 0], X[idx_pos, 1], c='blue', label='Class +1')
plt.scatter(X[idx_neg, 0], X[idx_neg, 1], c='red', label='Class -1')

x1_min, x1_max = X[:, 0].min() - 0.5, X[:, 0].max() + 0.5
x1_plot = np.linspace(x1_min, x1_max, 100)

x2_plot = -(b_val[0] * x1_plot + b0_val) / b_val[1]

plt.plot(x1_plot, x2_plot, 'k-', linewidth=2, label='Decision Boundary')
 
plt.xlabel('$x_1$')
plt.ylabel('$x_2$')
plt.title(f'SVM Decision Boundary (C={C})')
plt.legend()
plt.grid(True, alpha=0.3)
plt.show()

#Part 3
X_tilde = X * y.reshape(-1, 1)
w = cp.Variable(n)
quadratic = cp.sum_squares(X_tilde.T @ w)
linear = cp.sum(w)
objective = cp.Maximize(-0.5 * quadratic + linear)
constraints = [
    w >= 0,
    w <= C,
    w @ y == 0
]
prob = cp.Problem(objective, constraints)
prob.solve()
print("\n--- Dual Problem Results ---")
print("Status:", prob.status)
print(f"Optimal Dual Criterion Value: {prob.value:.4f}")

beta_dual = X_tilde.T @ w.value

print(f"Vector X_tilde^T * w: {beta_dual}")

#Part 4
import cvxpy as cp
import numpy as np
import matplotlib.pyplot as plt

train_data = np.loadtxt('S26 10-725 HW1 Student Version/Q5a_code/xy_train.csv', delimiter=',')
X_train = train_data[:, 0:2]
y_train = train_data[:, 2]
n_train = len(y_train) 

test_data = np.loadtxt('S26 10-725 HW1 Student Version/Q5a_code/xy_test.csv', delimiter=',')
X_test = test_data[:, 0:2]
y_test = test_data[:, 2]
n_test = len(y_test)   

print(f"Loaded Train: {n_train} rows, Test: {n_test} rows")

a_values = np.linspace(-5, 5, 50)
C_values = 2**a_values
errors = []

print("Starting loop over C values...")

for C_val in C_values:
    beta = cp.Variable(2)
    beta0 = cp.Variable()
    xi = cp.Variable(n_train) 

    objective = cp.Minimize(0.5 * cp.sum_squares(beta) + C_val * cp.sum(xi))

    constraints = [
        xi >= 0,
        cp.multiply(y_train, X_train @ beta + beta0) >= 1 - xi
    ]

    prob = cp.Problem(objective, constraints)
    prob.solve(warm_start=True) 

    b_opt = beta.value
    b0_opt = beta0.value

    scores = X_test @ b_opt + b0_opt
    predictions = np.sign(scores)
    
    predictions[predictions == 0] = 1
    error_rate = np.mean(predictions != y_test)
    errors.append(error_rate)

plt.figure(figsize=(10, 6))
plt.plot(C_values, errors, marker='o', linestyle='-', color='b')

plt.xscale('log') 

plt.xlabel('Cost Parameter $C$ (log scale)')
plt.ylabel('Misclassification Error (Test Set)')
plt.title('SVM Test Error vs Regularization Parameter C')
plt.grid(True, which="both", ls="-", alpha=0.4)
plt.show()

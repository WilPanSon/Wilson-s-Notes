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
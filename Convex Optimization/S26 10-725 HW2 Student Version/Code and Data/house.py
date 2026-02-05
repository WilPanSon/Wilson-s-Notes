import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.metrics import r2_score

from data import load_data


class Lasso:
    def __init__(self, alpha=1, max_iter=2000):
        self.alpha = alpha
        self.max_iter = max_iter
        self.coef_ = None

    def _loss(X, y):
        """Lasso loss function

        Args:
            X (nxd): features
            y (nx1): labels
        """
        mse_term = ...  ## YOUR IMPLEMENTATION
        l1_term = ...  ## YOUR IMPLEMENTATION
        return mse_term + l1_term

    def _sgrad(X, y):
        """Lasso subgradient

        Args:
            X (nxd): features
            y (nx1): labels
        """
        mse_grad = ...  ## YOUR IMPLEMENTATION
        l1_subgrad = ...  ## YOUR IMPLEMENTATION
        return mse_grad + l1_subgrad

    def fit(X, y):
        """Subgradient descent of Lasso

        Args:
            x (nxd): features
            y (nx1): labels
            a (float): weight of L1 regularization
            w0 (dx1): initial weights of Lasso
            N (int): total number of iterations
        Returns:
            coef_t (List[dx1]): coef_ for 0 <= t <= self.max_iter
            Lt (List[float]): the loss trajectory
        """
        self.coef_ = np.random.random((X.shape[1], 1))
        coef_t, Lt = [self.coef_.copy()], [self._loss(X, y)]
        for _ in range(self.max_iter):
            ## YOUR IMPLEMENTATION
            ...
        return coef_t, Lt

    def score(X, y):
        return r2_score(y, X @ self.coef_)


if __name__ == "__main__":
    np.random.seed(10725)
    
    features, x_train, x_test, y_train, y_test = load_data()
    print(f"Train xshape: {x_train.shape[0]}x{x_train.shape[1]}")
    print(f"Test xshape: {x_test.shape[0]}x{x_test.shape[1]}")
    print("Some Features:", list(features[:5]))

    ## YOUR IMPLEMENTATION

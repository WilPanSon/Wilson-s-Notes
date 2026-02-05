import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split


def load_data():
    house = pd.read_csv("house.csv").set_index("Id")
    X, Y = pd.get_dummies(house).drop("SalePrice", axis=1), house["SalePrice"]
    X["bias"] = 1
    x_train, x_test, y_train, y_test = train_test_split(X, Y, test_size=0.3)
    x_train, x_test, y_train, y_test = (
        x_train.to_numpy(dtype=float),
        x_test.to_numpy(dtype=float),
        y_train.to_numpy(dtype=float).reshape(-1, 1),
        y_test.to_numpy(dtype=float).reshape(-1, 1),
    )

    def normalize(x, mu=None, sig=None):
        if mu is not None and sig is not None:
            return (x - mu) / sig
        mu, sig = x.mean(), x.std()
        return (x - mu) / sig, mu, sig        

    x_train, xmu, xsig = normalize(x_train)
    x_test = normalize(x_test, xmu, xsig)
    y_train, ymu, ysig = normalize(y_train)
    y_test = normalize(y_test, ymu, ysig)

    return X.columns, x_train, x_test, y_train, y_test



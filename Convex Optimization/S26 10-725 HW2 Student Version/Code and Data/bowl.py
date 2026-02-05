import numpy as np
import matplotlib.pyplot as plt



def bowl(a: float, b: float):
    return lambda x, y : a * x ** 2 + b * y ** 2


def gd_f(x0: np.array, N: int, alpha: float, a: float, b : float):
    """Gradient descent of the quadratic bowl. Returns trajectory of xt
    and f(xt) as a function of time. 

    Args:
        x0 (np.array): inital point of descent
        N (int): number of iterations we will run gradient descent
        alpha (float): learning rate
        a,b (float): parameters of the bowl function 
    Returns:
        x_traj (List[np.array]): xt for all 0 <= t < N
        f_traj (List[float]): f(xt) for all 0 <= t < N
    """
    f = bowl(a,b)
    xt, f_traj, x_traj = x0, [], []
    for _ in range(N):
        ## YOUR IMPLEMENTATION HERE ##

        x_traj.append(...)
        f_traj.append(...)

    return x_traj, f_traj 


def gd_f_better(x0: np.array, N: int, alpha: SOMETYPE, a: float, b : float):
    """Gradient descent of the quadratic bowl. Returns trajectory of xt
    and f(xt) as a function of time. 

    Args:
        x0 (np.array): inital point of descent
        N (int): number of iterations we will run gradient descent
        alpha (float): learning rate
        a,b (float): parameters of the bowl function 
    Returns:
        x_traj (List[np.array]): xt for all 0 <= t < N
        f_traj (List[float]): f(xt) for all 0 <= t < N
    """
    f = bowl(a,b)
    xt, f_traj, x_traj = x0, [], []
    for _ in range(N):
        ## YOUR IMPLEMENTATION HERE ##

        x_traj.append(...)
        f_traj.append(...)

    return x_traj, f_traj 



if __name__ == "__main__":
    X0 = np.array([3., -2.])

    # Q5.1.3
    f_traj, x_traj = gd_f(x0=X0,...,a=1,b=2)

    # Q5.1.4 
    ## YOUR IMPLEMENTATION HERE ##

    # Q5.1.5
    ## YOUR IMPLEMENTATION HERE ##

    # Q5.1.7
    ## YOUR IMPLEMENTATION HERE ##

    # Q5.1.8
    f_traj, x_traj = gd_f_better(x0=X0,...,a=1,b=20)
import numpy as np
import pandas as pd


def LOOCV_featureselection(data, ids, outcomevar, dropcols, idcolumn, numestimators=1000):
    """
        Intermediate function.

    """
    # Separate data for leave-one-person-out-cross-validation (LOOCV)
    LOOCV_O = ids
    data[idcolumn] = data[idcolumn].apply(str)
    data_filtered = data[data[idcolumn] != LOOCV_O]
    data_cv = data[data[idcolumn] == LOOCV_O]

    # Train data - all other people in dataframe
    data_train = data_filtered.drop(columns=dropcols)
    X_train = data_train.drop(columns=[outcomevar])

    feature_list = list(X_train.columns)
    X_train = np.array(X_train)
    y_train = np.array(data_train[outcomevar])  # Outcome variable here

    from sklearn.ensemble import RandomForestRegressor
    # Instantiate model with numestimators decision trees
    rf = RandomForestRegressor(n_estimators=numestimators, random_state=0)
    # Train the model on training data
    rf.fit(X_train, y_train);

    # Get importances:
    importances = list(rf.feature_importances_)  # List of tuples with variable and importance
    important = pd.DataFrame()
    important['value'] = feature_list
    important['importances'] = importances

    return important
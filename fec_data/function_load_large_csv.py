import pandas as pd

def load_large_csv(filename, column_names=None, dtypes=None, usecols=None):
    chunksize = 10_000  # Number of rows to read per chunk (you can adjust this value based on available memory)
    df_list = []  # List to store individual chunks

    # Iterate over the file in chunks
    for chunk in pd.read_csv(filename, chunksize=chunksize, usecols=usecols, dtype=dtypes, names=column_names):
        # Perform any necessary data cleaning or preprocessing on the chunk
        # For example, you can remove unnecessary columns or apply transformations

        # Append the processed chunk to the list
        df_list.append(chunk)

    # Concatenate all the chunks into a single DataFrame
    df = pd.concat(df_list, ignore_index=True)

    return df
from apicaller import getUserData
import matplotlib as mpl
import pandas as pd

def main():
    df = getUserData(input("Reddit Username: "), write=True)


if __name__ == "__main__":
    main()
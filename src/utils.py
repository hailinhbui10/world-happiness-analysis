from pathlib import Path
from typing import Any, Union
import pandas as pd


def load_data_frame_from_strings(path_to_csv: Union[str, Path], **kwargs: Any) -> pd.DataFrame:
    """Load data frame with all column interpreted as having string type."""
    return pd.read_csv(path_to_csv, sep=";", decimal=".", encoding="utf-8", **kwargs)


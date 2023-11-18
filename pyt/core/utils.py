from datetime import datetime
import re

# import pytz


def datetime_from_str(date_string):
    date_object = datetime.strptime(date_string, "%m/%d/%Y %H:%M:%S %z")
    return date_object


def extract_and_concatenate_numbers(text: str) -> str:
    # Find all sequences of digits in the string
    numbers = re.findall(r"\d+", text)
    # Concatenate them together
    concatenated_numbers = "".join(numbers)
    return concatenated_numbers


if __name__ == "__main__":
    print(datetime_from_str("10/14/2023 18:00:00 +00:00"))

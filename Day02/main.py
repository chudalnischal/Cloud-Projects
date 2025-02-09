import sys 
import json 
import emoji 


def main():
    with open("buckets.json", "r") as f:
        data = json.load(f)
        summary(data)



def summary(data):
    size = []
    try: 
        if "buckets" in data:
            with open("summary.txt", "a") as f:
                 f.write("This is the summary of the buckets\n\n") 
            for bucket in data["buckets"]:
                with open("summary.txt", "a") as f:
                    f.write(f"name: {bucket['name']}\n")
                    f.write(f"region: {bucket['region']}\n")
                    f.write(f"size: {bucket['sizeGB']}\n")
                    f.write(f"versioning: {bucket['versioning']}\n")
                    f.write("\n")

    except KeyError:
        sys.exit("Invalid data format")

    try: 
        with open("delete.txt", "a", encoding="utf-8") as f:
            f.write(emoji.emojize('This bucket need to be deleted.:warning:\n\n'))

        for bucket in data["buckets"]:
            size = bucket.get("sizeGB")
            if size > 100:
                with open("delete.txt", "a", encoding="utf-8") as f:
                    f.write(f"name: {bucket['name']}\n")
                    f.write(f"region: {bucket['region']}\n")
                    f.write(f"size: {bucket['sizeGB']}\n")
                    f.write(f"versioning: {bucket['versioning']}\n")
                    f.write("\n")
            else: 
                continue
    except KeyError:
        sys.exit("Invalid data format")



if __name__ == "__main__":
    main()
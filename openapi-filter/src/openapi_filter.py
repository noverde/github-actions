import argparse

import yaml


def exclude_unused(spec):
    # TODO remove schemas and examples without references
    return spec


def exclude_extensions(spec):
    filtered = {}

    for key, value in spec.items():
        if isinstance(key, str) and key.startswith("x-"):
            continue
        elif isinstance(value, dict):
            filtered[key] = exclude_extensions(value)
        elif isinstance(value, (list, tuple, set)):
            filtered[key] = []
            for item in value:
                if isinstance(item, dict):
                    filtered[key].append(exclude_extensions(item))
                else:
                    filtered[key].append(item)
        else:
            filtered[key] = value

    return filtered


def exclude_by_path(spec, paths):
    filtered = spec

    if "paths" in filtered:
        for path in paths:
            filtered["paths"].pop(path, None)

    return filtered


def exclude_by_tag(spec, tags):
    filtered = {}
    tags = set(tags)

    for path, methods in spec.get("paths", {}).items():
        filtered[path] = {}

        for method, attributes in methods.items():
            if tags & set(attributes.get("tags", [])):
                continue
            else:
                filtered[path][method] = attributes

    return {**spec, "paths": filtered}


def apply_filters(spec, paths=None, tags=None, extensions=False):
    if extensions:
        spec = exclude_extensions(spec)

    if paths:
        spec = exclude_by_path(spec, paths)

    if tags:
        spec = exclude_by_tag(spec, tags)

    if paths or tags:
        spec = exclude_unused(spec)

    return spec


def output(spec, file=None):
    spec = yaml.safe_dump(spec)

    if file:
        with open(file, "w") as fp:
            fp.write(spec)
    else:
        print(spec)


def parse_arguments():
    parser = argparse.ArgumentParser(description="OpenAPI filter")
    parser.add_argument("file", metavar="FILE", type=open, help="OpenAPI file")
    parser.add_argument("-o", metavar="OUT", dest="out", help="output file")
    parser.add_argument("-x", dest="ext", action="store_true", help="exclude extensions")
    parser.add_argument(
        "-t",
        metavar="TAGS",
        dest="tags",
        type=lambda t: t.split(","),
        help="a list of comma separated tags",
    )
    parser.add_argument(
        "-p",
        metavar="PATHS",
        dest="paths",
        type=lambda p: p.split(","),
        help="a list of comma separated paths",
    )

    return parser.parse_args()


def main():
    args = parse_arguments()
    spec = yaml.safe_load(args.file.read())
    filtered = apply_filters(spec, args.paths, args.tags, args.ext)
    output(filtered, args.out)


if __name__ == "__main__":
    main()

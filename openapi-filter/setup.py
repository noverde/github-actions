from setuptools import find_packages, setup


def requirements():
    with open("requirements.txt") as fp:
        return fp.readlines()


setup(
    name="openapi_filter",
    version="1.0.0",
    description="CLI tool for filtering OpenAPI specification templates",
    author="Noverde Tecnologia",
    author_email="dev@noverde.com.br",
    packages=find_packages(),
    install_requires=requirements(),
    python_requires=">=3.8",
    entry_points={"console_scripts": ["openapi_filter=src.openapi_filter:main"]},
)

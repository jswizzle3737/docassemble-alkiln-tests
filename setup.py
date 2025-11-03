from setuptools import setup, find_packages
import os

def find_package_data(where='.', package=''):
    """
    Find package_data.
    
    Borrowed from Docassemble.
    """
    out = {}
    stack = [(where, '', package)]
    while stack:
        where, prefix, package = stack.pop(0)
        for name in os.listdir(where):
            fn = os.path.join(where, name)
            if os.path.isdir(fn):
                fp = os.path.join(prefix, name)
                pp = package + '.' + name if package else name
                stack.append((fn, fp, pp))
            else:
                out.setdefault(package, []).append(os.path.join(prefix, name))
    return out

setup(
    name='docassemble.alkilntests',
    version='1.0.0',
    description='ALKiln testing package for docassemble interviews',
    long_description='Automated testing environment for docassemble interviews using ALKiln. Write Gherkin test scenarios to validate your interview workflows.',
    long_description_content_type='text/markdown',
    author='jswizzle3737',
    author_email='your.email@example.com',
    license='The MIT License (MIT)',
    url='https://github.com/jswizzle3737/docassemble-alkiln-tests',
    packages=find_packages(),
    namespace_packages=['docassemble'],
    install_requires=[],
    zip_safe=False,
    package_data=find_package_data(where='docassemble/alkilntests/', package='docassemble.alkilntests'),
)
from setuptools import setup, find_packages
import os

def find_package_data(where='.', package=''):
    """
    Find package_data.
    
    Borrowed from Docassemble.
    Optimized to use pop() instead of pop(0) for O(1) performance.
    """
    out = {}
    stack = [(where, '', package)]
    while stack:
        where, prefix, package = stack.pop()
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
    description='Comprehensive ALKiln testing framework for docassemble interviews with organized test examples',
    long_description='Automated end-to-end testing environment for docassemble legal interviews using the ALKiln framework. Write behavior-driven Gherkin test scenarios to validate interview workflows, with categorized examples for common patterns including form validation, conditional logic, multi-page flows, and button navigation.',
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
from setuptools import setup

filename = 'rfhub2/version.py'
exec(open(filename).read())

setup(
    name='rfhub2',
    version=__version__,
    author='Pawel Bylicki',
    author_email='pawelkbylicki@gmail.com',
    url='https://github.com/pbylicki/rfhub2/',
    keywords='robotframework',
    license='Apache License 2.0',
    description='Webserver for robot framework assets documentation',
    long_description=open('README.md').read(),
    long_description_content_type='text/markdown',
    zip_safe=True,
    include_package_data=True,
    python_requires=">=3.6",
    install_requires=['Flask', 'watchdog', 'robotframework', 'SQLAlchemy', 'tornado'],
    extras_require={
        "postgresql": ["psycopg2-binary"]
    },
    classifiers=[
        "Development Status :: 4 - Beta",
        "License :: OSI Approved :: Apache Software License",
        "Operating System :: OS Independent",
        "Framework :: Robot Framework",
        "Programming Language :: Python",
        "Programming Language :: Python :: 3",
        "Topic :: Software Development :: Testing",
        "Topic :: Software Development :: Quality Assurance",
        "Intended Audience :: Developers",
    ],
    packages=[
        'rfhub2',
        'rfhub2.blueprints',
        'rfhub2.blueprints.api',
        'rfhub2.blueprints.doc',
        'rfhub2.blueprints.dashboard',
    ],
    scripts=[],
    entry_points={
        'console_scripts': [
            "rfhub2 = rfhub2.__main__:main"
        ]
    }
)

from setuptools import setup, find_packages

setup(
    name="discord-bot",
    version="0.1",
    packages=find_packages(),
    install_requires=[
        'discord.py',
    ],
    entry_points={
        'console_scripts': [
            'discord-bot = bot.main:main',
        ],
    },
)

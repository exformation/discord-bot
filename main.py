import discord
import requests
import re

intents = discord.Intents.default()
intents.message_content = True

client = discord.Client(intents=intents)

@client.event
async def on_ready():
    print('Logged on as', client.user)

@client.event
async def on_message(message):
    # don't respond to ourselves or outside the magic channel
    if message.author == client.user or message.channel.name != "magic-and-shit":
        return

    image_urls = []
    matches = re.findall(r'\[(.*?)\]', message.content)

    for match in matches:
        card_data = get_card_data(match)
        if card_data:
            image_urls.append(card_data['scryfall_uri'])
            image_urls.append(card_data['image_uris']['border_crop'])

    if image_urls:
        await message.channel.send('\n'.join(image_urls))

def get_card_data(card_name):
    response = requests.get(f'https://api.scryfall.com/cards/named?fuzzy={card_name}')
    if response.status_code == 200:
        return response.json()
    else:
        return None

client.run('token')

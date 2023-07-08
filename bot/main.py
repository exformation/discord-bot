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

    urls = []
    embeds = []
    matches = re.findall(r'\[(.*?)\]', message.content)

    for match in matches:
        card_data = get_card_data(match)
        if card_data:
            embed = discord.Embed(url='https://cards.scryfall.io')
            embed.set_image(url=card_data['image_uris']['border_crop'])
            embeds.append(embed)
            urls.append(card_data['scryfall_uri'])

    if urls:
        # await message.channel.send('\n'.join(urls))
        await message.channel.send('\n'.join(urls), embeds=embeds)


def get_card_data(card_name):
    # TODO: don't I need to join card_name with +?
    response = requests.get(f'https://api.scryfall.com/cards/named?fuzzy={card_name}')
    if response.status_code == 200:
        return response.json()
    else:
        return None


def main():
    # TODO: how do I load the token in safely?
    client.run(open('.env').read().strip())


if __name__ == "__main__":
    main()


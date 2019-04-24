import tweepy
import credential
import csv  # Import csv
from pprint import pprint

auth = tweepy.OAuthHandler(credential.consumer_key, credential.consumer_secret)
auth.set_access_token(credential.access_token, credential.access_token_secret)

api = tweepy.API(auth)

# Open/create a file to append data to
csvFile = open('Adrikacang.csv', 'w', encoding='utf-8')

# Use csv writer
csvWriter = csv.writer(csvFile, delimiter=',', lineterminator='\n')
rows = 0

csvWriter.writerow(
    ['id', 'text', 'created_at', 'source', 'location', 'retweet_count', 'reply_count',
     'favorite_count', 'quote_count', 'is_quote_status'])

for tweet in tweepy.Cursor(api.search,
                           q="@adrikacang",
                           result_type="mixed",
                           tweet_mode="extended",
                           trim_user=True).items():
    # Write a row to the CSV file. I use encode UTF-8
    place = ''
    retweet = 0
    reply = 0
    favorite = 0
    quote = 0

    if hasattr(tweet, 'place') and hasattr(tweet.place, 'name'):
        place = tweet.place.name

    if hasattr(tweet, 'retweet_count'):
        retweet = tweet.retweet_count

    if hasattr(tweet, 'reply_count'):
        reply = tweet.reply_count

    if hasattr(tweet, 'favorite_count'):
        favorite = tweet.favorite_count

    if hasattr(tweet, 'quote_count'):
        quote = tweet.quote_count

    csvWriter.writerow(
        [tweet.id_str, tweet.full_text, tweet.created_at, tweet.source, place, retweet,
         reply,
         favorite, quote, tweet.is_quote_status])
    rows += 1
	


print("saving", rows, "results!")
csvFile.close()

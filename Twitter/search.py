import twitter
import credential
import csv  # Import csv


api = twitter.Api(consumer_key=credential.consumer_key,
                  consumer_secret=credential.consumer_secret,
                  access_token_key=credential.access_token,
                  access_token_secret=credential.access_token_secret)

# Open/create a file to append data to
csvFile = open('Anti-social behaviour - Barnsley.csv', 'w', encoding='utf-8')

# Use csv writer
csvWriter = csv.writer(csvFile, delimiter=',', lineterminator='\n')
rows = 0

csvWriter.writerow(
    ['id', 'text', 'user_name'])
			
results = api.GetSearch(
    raw_query="q=Anti-Social%20behaviour%20AND%Barnsley")
	
for r in results:
    csvWriter.writerow([r.id, r.text, r.user.screen_name])
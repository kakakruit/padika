from flask import Flask, request, jsonify
import pickle
import numpy as np

# Load your sentiment analysis model
model = pickle.load(open('SA_model.pkl', 'rb'))

app = Flask(__name__)


@app.route('/predict', methods=['POST'])
def predict():
    comments_data = request.get_json()  # Get JSON data from the request body
    comments = comments_data.get('comments')  # Extract the comment list

    # Pre-process comments as needed (ensure consistency with Flutter code)
    processed_comments = [comment['commentText'] for comment in comments]
    input_query = np.array([processed_comments])

    result = model.predict(input_query)[0]  # Make predictions
    sentiments = [{'userId': comments['userId'],
                   'sentiment': str(sentiment)} for sentiment in result]

    # Update Firebase with sentiment data (assuming proper authorization)
    # Replace with your secure Firebase access and update logic
    # ...
    print('heelo')
    return jsonify({'sentiments': sentiments})


if __name__ == '__main__':
    app.run(debug=True)

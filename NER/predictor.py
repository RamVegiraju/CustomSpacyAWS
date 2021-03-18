from flask import Flask
import flask
import scispacy
import spacy
import os
import json
import logging

nlp = spacy.load("en_core_sci_sm")


# The flask app for serving predictions
app = Flask(__name__)
@app.route('/ping', methods=['GET'])
def ping():
    # Check if the classifier was loaded correctly
    """
    try:
        print("Working")
        status = 200
        logging.info("Status : 200")
    except:
        print("Error here")
        status = 400
    """
    health = nlp is not None
    status = 200 if health else 404
    return flask.Response(response= '\n', status=status, mimetype='application/json')


@app.route('/invocations', methods=['POST'])
def transformation():
    # Get input JSON data and convert it to a DF
    input_json = flask.request.get_json()
    input = input_json['input']
    doc = nlp(input)
    predictions = str(doc.ents)

    # Transform predictions to JSON
    result = {
        'output': predictions
        }

    resultjson = json.dumps(result)
    return flask.Response(response=resultjson, status=200, mimetype='application/json')
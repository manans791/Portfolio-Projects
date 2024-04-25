from flask import Flask,request,render_template,jsonify
import numpy as np
import pandas as pd
import joblib
import pickle

app=Flask(__name__)

model = pickle.load(open("classifer_regressor.pkl","rb"))

df=pd.read_csv("Cleaned_data.csv")



@app.route('/')
def home():




    return render_template("index.html"#Gender=Gender,Age=Age,Smoker=Smoker,Cigs=Cigs,BP=BP,Stroke=Stroke,
                           #Hypertension=Hypertension,Cholestrol=Cholestrol,SYSBP=SYSBP,Diabetes=Diabetes,BMI=BMI,Heartrate=Heartrate,
                           #Glucose=Glucose,Education=Education,diabetes_exist=diabetes_exist
        )




@app.route('/predict',methods=["POST"])
def predict():
    Gender= request.form.get('Gender')
    Age = request.form.get('Age')
    Smoker = request.form.get('Smoker')
    Cigs = request.form.get('Cigs')
    BP = request.form.get('BP')
    Stroke = request.form.get('Stroke')
    Hypertension = request.form.get('Hypertension')
    Cholestrol = request.form.get('Cholestrol')
    SYSBP = request.form.get('SYSBP')
    Diabetes = request.form.get('Diabetes')
    BMI = request.form.get('BMI')
    Heartrate = request.form.get('Heartrate')
    Glucose = request.form.get('Glucose')
    Education = request.form.get('Education')
    diabetes_exist = request.form.get('diabetes_exist')

    input_data = pd.DataFrame([[Gender, Age, Education, Smoker, Cigs, BP, Stroke, Hypertension,
                                Diabetes, Cholestrol, SYSBP, diabetes_exist, BMI, Heartrate, Glucose]])

    # Make prediction using the loaded model
    prediction = model.predict(input_data)

    print(prediction)

    # Prepare the response as a JSON object
    response = int(prediction[0])

    # Define messages based on response
    if response == 1:
        message = "According to the model and the algorithm, you are predicted to have a heart attack based on your habits."
    elif response==0:
        message = "According to the model and the algorithm, you are not predicted to have a heart attack based on your habits."

    # Print the message (for demonstration purposes)
    print(message)

    # Return a JSON response with the prediction and message
    return render_template("index.html", prediction=response, message=message)







if __name__ == '__main__':
        app.run(debug=True)
# import the Package
import os
import pathlib
import cv2
import numpy as np 
from PIL import Image , ImageOps
import streamlit as st
from tensorflow.keras.models import load_model
from keras.preprocessing.image import img_to_array, load_img
import tensorflow as tf
from PIL import Image

class_name = ["airplane", "automobile" , "bird" , "cat" , "deer" , "dog" , "frog" , "horse" , "ship" , "truck"]

# Create a function to load my saved model
@st.cache(allow_output_mutation=True)
def load_my_model():
    model = tf.keras.models.load_model("final_model.h5")
    return model

model = load_my_model()

# Create a title of web App
st.title("Image Classification with Cifar10 Dataset")
st.header("Please Upload images related to this things...")
st.text(class_name)

# load and prepare the image
def load_image(filename):
    # load the image
    img = load_img(filename, target_size=(32, 32))
    # convert to array
    img = img_to_array(img)
    # reshape into a single sample with 3 channels
    img = img.reshape(1, 32, 32, 3)
    # prepare pixel data
    img = img.astype('float32')
    img = img / 255.0
    return img

# create a file uploader and take a image as an jpg or png
image_file  = st.file_uploader("Upload the image" , type=["jpg" , "png"])
if image_file  is not None:
    file_details = {
        "Filename":image_file.name,
        "FileType":image_file.type,
        "FileSize":image_file.size,
    }

if st.button("Predict"):
    image = Image.open(image_file)
    st.image(image , use_column_width=True)
    path = pathlib.Path(image)
    print(path)
    img = image.save(f""+path+"./images/"+image_file.name)
    img_to_predict = load_image(f""+path+"./images/"+image_file.name)
    predictions = np.argmax(model.predict(img_to_predict), axis=-1)
    string = "Image mostly same as : - " + class_name[predictions[0]]
    st.success(string)
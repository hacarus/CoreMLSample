#!/usr/bin/env python3
# convert_to_ml_model.py


"""
This program is convert to CoreML model for iOS from caffe.
"""

__date__ = '2018/07/04'

import coremltools

coreml_model = coremltools.converters.caffe.convert(
    ('./../CaffeModels/SqueezeNet/squeezenet_v1.1.caffemodel', './../CaffeModels/SqueezeNet/deploy.prototxt'),
    image_input_names = 'image',
    class_labels = './../CaffeModels/SqueezeNet/imagenet1000.txt')

coreml_model.author = 'Author' # Autor
coreml_model.license = 'License' # License.
coreml_model.short_description = 'Description' # core ml description.

coreml_model.save('./../MLModels/Squeeze.mlmodel') # The name converted from caffe model.



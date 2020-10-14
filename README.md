# Robot-Navigation-Computer-Vision

This projected was completed for an undergraduate thesis published at Ryerson University. Included is the code used for object recognition, detection and depth calculation used for the specific application of a butterfly valve. The reason this project proved difficult initially was because this would all be done with the use of one camera on the robot. Utilizing one camera for depth perception is like trying to perceive depth with one eye closed. 

The robot would first need to learn how the butterfly valve looks along with the dimensions. The robot would then be able to correlate the trained image data with what the camera picks up live to detect the valve. With the valve identified and detected, I implemented a mathematical technique that would predict depth of an object using one camera as long as the dimensions of the object is known. The image below illustrates the described method being implemented with an accuracy of 93%.

The code provided is very useful becuase it works regardless of what object or image you are trying to detect. This allows it to be applicable to many computer vision proojects.

For further details, please refer to my paper found using this link: https://docdro.id/XtHB9rr. You can also reach out to me for any questions.

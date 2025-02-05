import 'package:flutter/material.dart';

Widget blogCard({
  required String title,
  required String description,
  required String author,
  required void Function()? onPressed,
  required double sheight,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: double.infinity,
      // height: sheight * .36,
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10).copyWith(
        bottom: 0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade400,
          width: 2,
        ),
        // color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //author detail
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //profile image
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  size: sheight * .04,
                ),
              ),

              //space
              SizedBox(
                width: sheight * .02,
              ),

              //name
              Text(
                author,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 20,
                ),
              ),

              //time
              Text("")
            ],
          ),

          //space
          SizedBox(
            height: sheight * .02,
          ),

          //thumbnail
          Image.asset(
            "assets/sample.jpeg",
            fit: BoxFit.cover,
            width: double.infinity,
          ),

          //space
          SizedBox(
            height: sheight * .01,
          ),

          //title
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 20,
            ),
          ),

          //space
          SizedBox(
            height: sheight * .02,
          ),

          //button ----> like, comment, save
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //like
              Row(
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Colors.grey.shade800,
                  ),
                  Text(
                    "Like",
                    style: TextStyle(
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              //comment
              Row(
                children: [
                  Icon(
                    Icons.comment_rounded,
                    color: Colors.grey.shade800,
                  ),
                  Text(
                    "comment",
                    style: TextStyle(
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              //save
              Row(
                children: [
                  Icon(
                    Icons.bookmark_border,
                    color: Colors.grey.shade800,
                  ),
                  Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

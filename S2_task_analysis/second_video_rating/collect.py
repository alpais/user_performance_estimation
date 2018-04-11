#!/usr/bin/env python

import os
import re

def collect_subjects(dir):
  # We are here:
  # <dir>/Sxx/Videos/Sxx_Demo_yy.mp4-<rater>.txt
  # ^
  subjs = os.listdir(dir)
  subjs = filter(lambda d: os.path.isdir(os.path.join(dir, d)), subjs)
  subjs.sort()
  return subjs

def collect_ratings(subj, dir):
  # We are here:
  # <dir>/Sxx/Videos/Sxx_Demo_yy.mp4-<rater>.txt
  #           ^
  rating_files = os.listdir(dir)
  rating_files = filter(lambda d: os.path.isfile(os.path.join(dir, d)) and d.endswith(".txt"), rating_files)
  rating_files.sort()
  return rating_files

def collect_rating_trial(subj, file, path, raters, match, ftrials):
  # We are here:
  # <dir>/Sxx/Videos/Sxx_Demo_yy.mp4-<rater>.txt
  #                  ^
  # extract as much as we can from the file name:
  subj_no = match.group(1)
  demo_no = match.group(2)
  rater = match.group(3).lower()

  if rater not in raters.keys():
    print " * Unmatched rater", rater, "in", path
    return

  rater_no = raters[rater]

  f = open(path, "r")
  line1 = f.readline() # ignored, redundant info
  line2 = f.readline() # ignored, redundant info
  line3 = f.readline() # ignored, redundant info
  line4 = f.readline()
  f.close()

  regex2 = re.compile('^answers: (\d+),(\d+),(\d+),(\d+)$', re.IGNORECASE)
  match2 = regex2.match(line4.strip())

  if match2 is None:
    print " * Unmatched answer line (trial) ", line4, "in", path
    return

  ans1 = match2.group(1)
  ans2 = match2.group(2)
  ans3 = match2.group(3)
  ans4 = match2.group(4)
#  ans5 = match2.group(5)
#  ans6 = match2.group(6)

  line = str(subj_no) + "\t" + \
         str(demo_no) + "\t" + \
         str(rater_no) + "\t" + \
         str(ans1) + "\t" + \
         str(ans2) + "\t" + \
         str(ans3) + "\t" + \
         str(ans4) + "\n" 
 #        str(ans5) + "\t" + \
 #        str(ans6) + "\n"

  ftrials.write(line)

def collect_rating_user(subj, file, path, raters, fusers):
  # We are here:
  # <dir>/Sxx/Videos/<rater>.txt
  #                  ^
  # extract as much as we can from the file name:

  # Check correct format:
  regex = re.compile('^(\w+)\.txt$', re.IGNORECASE)
  match = regex.match(file)
  if match is None:
    print " * Unknown file type:", path
    return

  rater = match.group(1)

  if rater not in raters.keys():
    print " * Unknown rater for file:", path
    return

  rater_no = raters[rater]
  subj_no = subj[1:]

  f = open(path, "r")
  line1 = f.readline() # ignored, redundant info
  line2 = f.readline() # ignored, redundant info
  line3 = f.readline() # ignored, redundant info
  line4 = f.readline() # ignored, redundant info
  line5 = f.readline()
  f.close()

  regex2 = re.compile('^answers: (\d+),(\d+),(\d+),(\d+)$', re.IGNORECASE)
  match2 = regex2.match(line5.strip())

  if match2 is None:
    print " * Unmatched answer line (user) ", line4, "in", path
    return

  ans1 = match2.group(1)
  ans2 = match2.group(2)
  ans3 = match2.group(3)
  ans4 = match2.group(4)

  line = str(subj_no) + "\t" + \
         str(rater_no) + "\t" + \
         str(ans1) + "\t" + \
         str(ans2) + "\t" + \
         str(ans3) + "\t" + \
         str(ans4) + "\n"

  fusers.write(line)


def collect_rating_file(subj, file, path, raters, ftrials, fusers):
  # We are here:
  # <dir>/Sxx/Videos/Sxx_Demo_yy.mp4-<rater>.txt
  #                  ^
  # decide if it's a trial or user file:
  regex = re.compile('^S(\d\d)_Demo_(\d+)\.mp4\-(\w+)\.txt$', re.IGNORECASE)
  match = regex.match(file)

  if match is None:
    collect_rating_user(subj, file, path, raters, fusers)
  else:
    collect_rating_trial(subj, file, path, raters, match, ftrials)

def collect(dir, raters):
  ftrials = open('trials.txt', 'w')
  fusers = open('users.txt', 'w')
  subjs = collect_subjects(dir)
  for subj in subjs:
    path = os.path.join(dir, subj)
    path = os.path.join(path, "Videos")
    rating_files = collect_ratings(subj, path)
    for rating_file in rating_files:
      rating_path = os.path.join(path, rating_file)
      collect_rating_file(subj, rating_file, rating_path, raters, ftrials, fusers)
  fusers.close()
  ftrials.close()

if __name__ == "__main__":
  print "Hello, starting script!"
  raters = {'test':0,
            'test2': 0,
            'lucia': 0,
            'walid': 1,
            'jacob': 2}
  collect("ratings", raters)
  print("Collection done!")

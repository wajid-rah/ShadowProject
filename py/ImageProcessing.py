import cv2 as cv
import numpy as np
import os


def convert_video_to_frame(source, destination):
    frame_no = 0
    if os.path.exists(source):
        video_obj = cv.VideoCapture(source)
        while True:
            isTrue, frame = video_obj.read()  # Convert video to frame

            # If video playing is over
            if not isTrue:
                # No need frame_no =+ 1 after the end of video
                break
            cv.imwrite(destination + '/' + str(frame_no) + '.jpg', frame)  # Save Frames
            frame_no += 1
    else:
        print('The path ', source, ' does not exists.')
    print('Generate {} no of frames in {} folder.'.format(frame_no, destination))


def get_total_frames(folder_path):
    no_of_frames = 0
    if os.path.exists(folder_path):
        for img in os.listdir(folder_path):

            if img.endswith('.jpg'):
                no_of_frames += 1
    return no_of_frames


def get_particular_frame_position(no_of_frames, frame_path, target_img):
    frame_ref_path = frame_path + '/' + target_img
    print('\nTarget Ref path: ', frame_ref_path)

    position = 0
    if os.path.exists(frame_ref_path):
        reference_img = cv.imread(frame_ref_path)  # Load target image

        while position < no_of_frames:
            img = cv.imread(frame_path + '/' + str(position) + '.jpg')
            # print(frame_path + '/' + str(position) + '.jpg')
            position += 1
            status = cv.subtract(reference_img, img)  # np.any(result) returns >0 if any mismatch otherwise 0
            if not np.any(status):
                print('Frame Match Found at ', position, ' position')
                break
        if position == no_of_frames:
            print('The Target image : {} is not found.'.format(target_img))
            position = 0
    else:
        print('The reference path :{} does not exists.'.format(frame_ref_path))
    return position


def get_loading_time(frame_path, target_img, DURATION_OF_VIDEO):
    path = frame_path + '/' + target_img
    # print('Target image:: {} '.format(path))

    no_of_frames = get_total_frames(folder_path=frame_path)
    ref_img_position = get_particular_frame_position(no_of_frames, frame_path=frame_path, target_img=target_img)

    fps = no_of_frames / int(DURATION_OF_VIDEO)  # (fps = NO_OF_FRAMES/duration_of_video)
    print('fps: ', fps)
    if fps != 0:
        load_time = ref_img_position / fps
    else:
        load_time = 0

    # print('\nLoad Time: {:8.2f} secs.'.format(load_time))

    # video_obj = cv.VideoCapture(source)
    # print('Estimated fps:{}'.format(fps))
    # c_fps = video_obj.get(cv.CAP_PROP_FPS)
    # print('Real fps: {}'.format(c_fps))
    #
    # print('Estimated total_frames:{} '.format(no_of_frames))
    # frame_count = int(video_obj.get(cv.CAP_PROP_FRAME_COUNT))
    # print('Real total_frames: {}'.format(frame_count))
    #
    return load_time


def remove_all_files(folder_path='../Frame'):
    if os.path.exists(folder_path):
        for file in os.listdir(folder_path):
            file_path = folder_path + '/' + file
            os.remove(file_path)
        print('\nRemoving all files completed.')
    else:
        print('No such frame path :{} exists.'.format(folder_path))

#
# remove_all_files('../Frame/AppLaunchFrame')
# remove_all_files('../Frame/NavigationFrame')
# remove_all_files('../Frame/VideoContentFrame')
#
# print('\nConversion of Video to frame begins...')
#
# print('\tFor App Launch')
# convert_video_to_frame('../RecordedVideo/appLaunch.mp4', '../Frame/AppLaunchFrame')
#
# print('\n\tFor Navigation ')
# convert_video_to_frame('../RecordedVideo/Navigation.mp4', '../Frame/NavigationFrame')
#
# print('\n\tFor Video plaback')
# convert_video_to_frame('../RecordedVideo/youtubeVideo.mp4', '../Frame/VideoContentFrame')
#

# print('\nCalculating Loading time...')
# video_load_time = get_loading_time('../Frame/VideoContentFrame', '10.jpg')
# print('Video Loading time : {} secs.'.format(video_load_time))
#
# app_launch_time = get_loading_time('../Frame/AppLaunchFrame', '9.jpg')
# print('App Launch time : {} secs.'.format(app_launch_time))
#
# nav_load_time = get_loading_time('../Frame/NavigationFrame', '58.jpg')
# print('Navigation Loading time : {} secs.'.format(nav_load_time))

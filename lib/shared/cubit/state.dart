abstract class SocialStates{}

class InitialState extends SocialStates{}

// Login States
class LoadingUserLogin extends SocialStates{}
class SuccessUserLogin extends SocialStates{
  final String uId;

  SuccessUserLogin(this.uId);
}
class FaieldUserLogin extends SocialStates{
  final String error;
  FaieldUserLogin(this.error);
}

// Register States
class LoadingUserRegister extends SocialStates{}
class SuccessUserRegister extends SocialStates{}
class FaieldUserRegister extends SocialStates{
  final String error;
  FaieldUserRegister(this.error);
}
// Create user States
class LoadingUserCreate extends SocialStates{}
class SuccessUserCreate extends SocialStates{}
class FaieldUserCreate extends SocialStates{
  final String error;
  FaieldUserCreate(this.error);
}

// Get user Data States
class LoadingGetUserData extends SocialStates{}
class SuccessGetUserData extends SocialStates{}
class FaieldGetUserData extends SocialStates{
  final String error;
  FaieldGetUserData(this.error);
}
// Visible password
class ChangeVisiabilityPassword extends SocialStates{}

// Bottom Nav Bar
class ChangeBottomNavBar extends SocialStates{}

// Add Post
class NewPostAdd extends SocialStates{}

// Img Picker Profile
class ChangeProfileImgSuccess extends SocialStates{}
class ChangeProfileImgFailed extends SocialStates{}
class UploadProfileImgSuccess extends SocialStates{}
class UploadProfileImgFailed extends SocialStates{}
// Cover Img
class ChangeCoverImgSuccess extends SocialStates{}
class ChangeCoverImgFailed extends SocialStates{}
class UploadCoverImgSuccess extends SocialStates{}
class UploadCoverImgFailed extends SocialStates{}

// update User Data & Imges
class UpdateUserDataLoading extends SocialStates{}
class UpdateUserDataFailed extends SocialStates{}
class UpdateUserProfileImgLoading extends SocialStates{}
class UpdateUserCoverImgLoading extends SocialStates{}

// new Post
class CreatePostLoasdingState extends SocialStates{}
class CreatePostSuccessState extends SocialStates{}
class CreatePostFailedState extends SocialStates{}
// chaaat
class CreateChatLoasdingState extends SocialStates{}
class CreateChatSuccessState extends SocialStates{}
class CreateChatFailedState extends SocialStates{}

// post Img
class GetPostImgSuccess extends SocialStates{}
class GetPostImgFailed extends SocialStates{}
// Remove post Img
class RemovePostImg  extends SocialStates{}
// chat Img
class GetChatImgSuccess extends SocialStates{}
class GetChatImgFailed extends SocialStates{}

// get Posts
class GetPostsLoadingState extends SocialStates{}
class GetPostsSuccessState extends SocialStates{}
class GetPostsFailedState extends SocialStates{
  final String error;
  GetPostsFailedState(this.error);}

// posts Likes
class GetPostsLikesSuccessState extends SocialStates{}
class GetPostsLikesFailedState extends SocialStates{}

// posts Comment
class GetPostsCommentSuccessState extends SocialStates{}
class GetPostsCommentFailedState extends SocialStates{}

// get users
class GetUsersLoadingState extends SocialStates{}
class GetUsersSuccessState extends SocialStates{}
class GetUsersFailedState extends SocialStates{
  final String error;
  GetUsersFailedState(this.error);}

// send message
class SendMessageSuccessState extends SocialStates{}
class SendMessageFailedState extends SocialStates{}
// receive message
class ReceiveMessageSuccessState extends SocialStates{}
class ReceiveMessageFailedState extends SocialStates{}

// comments
class GetCommentsSuccessState extends SocialStates{}
class GetCommentsFailedState extends SocialStates{}

class SendCommentSuccessState extends SocialStates{}
class SendCommentFailedState extends SocialStates{}

// emoji
class ChangeEmoji extends SocialStates{}
// focusNode
class ChangeFocus extends SocialStates{}



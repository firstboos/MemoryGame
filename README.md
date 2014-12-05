MemoryGame
==========

Memory Game for iPhone

이 소스는 Learning Objective-C by Developing iPhone Games 라는 책의 Chapter 3 의 소스를 직접 작성해서 Run 했을때, 제대로 동작하지 않는 부분을 수정한 것입니다.
원 저작자에게 허락을 받지 않은 상태라 문제가 있으면 소스를 내리도록 하겠습니다.

문제가 되었던 부분은 UIImage 객체를 같은지 비교하는 부분이 있었는데, UIImage 객체 비교를 위해서 ios8 에서 지원되는 CGImageRef 를 사용했습니다.

화면 레이아웃은 XCode 6.X 의 Size Classes 기능에 익숙하지 않아서, 에뮬레이터를 iphone6 로 맞추고 작업했습니다. 이 부분은 수정해야 할듯하네요.

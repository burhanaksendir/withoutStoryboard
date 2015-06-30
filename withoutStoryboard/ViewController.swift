//
//  ViewController.swift
//  withoutStoryboard
//
//  Created by yasin turkoglu on 30.06.2015.
//  Copyright (c) 2015 yasin turkoglu. All rights reserved.
//

import UIKit
import MediaPlayer



class ViewController: UIViewController {

    //moviplayercontroller ve textView ckass değişkenlerimizi nil olarak tanımlayalım.
    //daha sonra viewDidLoad'da çağrılacak createContent değişkeninde initiate edilecekler.
    var moviePlayerController:MPMoviePlayerController! = nil
    var textView:UITextView! = nil
    var dummyText:String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ut arcu volutpat, tristique ex vitae, pulvinar ante. Pellentesque tincidunt, urna at facilisis aliquet, tortor est hendrerit orci, ut gravida mauris nibh a felis. Fusce in molestie erat. Fusce ornare efficitur fermentum. Duis eu massa porta, suscipit justo ut, eleifend velit. In et orci orci. Nunc at nisl vel erat rhoncus eleifend. Aenean posuere diam vel odio tempus cursus. Nam mollis placerat ipsum nec lobortis. Nam quis aliquam eros, et interdum metus. Nunc eget orci a odio vulputate tincidunt. Donec vehicula sed risus eget iaculis. Fusce venenatis pulvinar ex, ut pulvinar ligula cursus eget. Vestibulum felis lorem, mattis id turpis lacinia, accumsan luctus nisl. Ut rutrum quam ut consequat aliquet. Curabitur quis urna erat. Maecenas elit sem, pellentesque vel feugiat id, egestas vitae ante. Aliquam pharetra porttitor magna quis iaculis. Sed nec quam luctus, laoreet nulla a, mollis mauris. Quisque viverra finibus dictum. Vestibulum hendrerit massa risus, eget venenatis enim varius in. Duis aliquet leo eu laoreet fermentum. Curabitur ac urna lorem. Donec vitae iaculis lorem. Praesent vehicula convallis aliquam. Duis non posuere lacus. Sed a consectetur nisi, sed pulvinar dolor. Donec pulvinar vestibulum lorem, sit amet rutrum turpis elementum a. Ut sodales arcu et mauris ullamcorper lobortis. Proin faucibus ipsum eu neque auctor placerat. Donec sit amet varius enim, vitae molestie purus. Integer congue in augue vel maximus. In facilisis at risus sit amet elementum. Pellentesque vulputate, mi vel pellentesque viverra, eros massa lacinia est, pellentesque sollicitudin libero purus sed odio. Fusce at quam bibendum, interdum dui non, placerat neque. Morbi egestas cursus rutrum. Integer sit amet ligula in dui tempor pretium. Cras dapibus eu mauris id feugiat. Phasellus maximus efficitur neque, a imperdiet ipsum suscipit nec. Vestibulum vehicula mauris nisl, et convallis est scelerisque id. Vestibulum sit amet hendrerit est. Nullam ut risus lacus. Aliquam pellentesque leo id rhoncus aliquam. Donec ac risus libero. Duis laoreet ornare sapien placerat consequat. Cras faucibus rhoncus viverra. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec rutrum, nibh ac facilisis aliquam, quam elit malesuada nibh, at sodales turpis ligula id sapien. Donec a lacus sagittis, dignissim est ac, mollis lacus. Nullam non ullamcorper mauris, sed dignissim nisi. Maecenas scelerisque ex turpis, auctor rhoncus justo convallis in. Praesent sodales fringilla est vitae ultrices. Fusce rutrum neque in dui maximus, et pretium mauris laoreet."
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //viewController'ımız kendi altında bir view'e sahiptir.
        //tüm objelerimizi bu view içerisine tanımlayacağız.
        //öncelikle view'in background rengini beyaz yapalım.
        //ufak bir hatırlatma uygulamanın çalışacağı cihazlar için gerekli launchScreen'leri eklemeyi unutmayalım.
        self.view.backgroundColor = UIColor.whiteColor()
        
        //createContent custom metoduyla içeriği oluşturuyoruz.
        createContent()
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        //status bar'ın görüntülenme durumunu burada değiştirebiliriz. şimdilik görüntülenmesin.
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        //ekran oriyantasyonu cihaz tutuş pozisyonuna göre dönebilsin.
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        //cihazın destekleyeceği oriyantasyonları belirleyelim.
        var currentSupportedOrientations:Int = Int(UIInterfaceOrientationMask.All.rawValue) // cihazın desteklediği tüm yönler
//        currentSupportedOrientations = Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue) // baş aşağı dışında kalan tüm yönler
//        currentSupportedOrientations = Int(UIInterfaceOrientationMask.Landscape.rawValue) // sadece yatay yönler
//        currentSupportedOrientations = Int(UIInterfaceOrientationMask.Portrait.rawValue) // sadece dik yön
//        currentSupportedOrientations = Int(UIInterfaceOrientationMask.LandscapeLeft.rawValue) // sadece yatay sol yön
//        currentSupportedOrientations = Int(UIInterfaceOrientationMask.LandscapeRight.rawValue) // sadece yatay sağ yön
//        currentSupportedOrientations = Int(UIInterfaceOrientationMask.PortraitUpsideDown.rawValue) // sadece baş aşağı yönü
        return currentSupportedOrientations
    }
    
    
    
    //burada cihazın tutuş yönü değiştiğinde ekran düzenin değişmesini sağlayacak tetikleyici delegate metodlarını ekliyoruz.
    //viewWillTransitionToSize delegate metodu IOS8 ve sonrası için kullanılacak metodumuz IOS8 öncesi için willRotateToInterfaceOrientation metodumuzu kullanacağız.
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        //IOS8 ve sonrası için interface animasyonunun hedef ölçülerle ve ne kadar sürede gerçekleşeceğini bu metodla öğreniyor ve updateContent metodumuza aktarıyoruz.
        updateContent(size, transitionDuration:coordinator.transitionDuration())
        
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        //IOS8 ve öncesi içinse interface animasyonunun hedef ölçülerle ve ne kadar sürede gerçekleşeceğini bu metodla öğreniyor ve updateContent metodumuza aktarıyoruz.
        //fakat burada viewWillTransitionToSize metodunda olduğu gibi hedef oryantasyon ölçülerini almak yerine metod bize hedef oryantasyonun ne oloduğunu veriyor.
        //bu nedenle hedef oryantasyona göre yeni hedef ölçülerimizi almak için hazırladığımız basit bir converter metoduyla ölçülerimizi alıyoruz.
        let targetSize:CGSize = getTargetSizeAccordingToTheTargetOrientation(toInterfaceOrientation)
        updateContent(targetSize, transitionDuration:duration)
    }
    
    
    private func getTargetSizeAccordingToTheTargetOrientation(orientation:UIInterfaceOrientation) -> CGSize {
        var targetSize:CGSize = self.view.frame.size
        if UIInterfaceOrientationIsLandscape(orientation) {
            targetSize = CGSizeMake(self.view.frame.size.height, self.view.frame.size.width)
        }
        return targetSize
    }


    
    private func updateContent(destinationScreenSize:CGSize, transitionDuration:NSTimeInterval) {
        if self.moviePlayerController != nil {

            //öncelikle gelen videonun en boy oranını hesaplayalım ve moviewPlayerController.view'in frame size'ını bu orana göre yeniden düzenleyelim.
            let videoNaturalAspectRatio = self.moviePlayerController.naturalSize.height / self.moviePlayerController.naturalSize.width
            
            //bu en boy oranını kullanarak default'da protrait mod için moviewPlayer'ın ölçülerini belirleyelim
            var calculatedScaleOfTheWidth:CGFloat = destinationScreenSize.width
            var calculatedScaleOfTheHeight:CGFloat = calculatedScaleOfTheWidth * videoNaturalAspectRatio
            
            //burada ufak bir detay var. yatay pozisyonda ölçeklenidirilmiş video muhtemelen ekranın tamamını kaplayacak ve altta yer alan text alanının görünmesini engelleyecek
            //bu nedenle calculatedScaleOfTheHeight'i videoNaturalAspectRatio ile ölçeklendirmek yerine destination height'in yarısını alıyoruzki yatay pozisyonda videonun altında bir miktar yer kalsın.
            if destinationScreenSize.width > destinationScreenSize.height {
                calculatedScaleOfTheHeight = destinationScreenSize.height / 2
            }
            
            //şimdi bu yeni ölçüleri bir size'a atayalım.
            var newSizeOfTheMoviewPlayerFrame:CGSize = CGSizeMake(calculatedScaleOfTheWidth, calculatedScaleOfTheHeight)

            //ve yeniden boyut belirleme işlemini transitionDuration'la aldığımız süreyle birlikte linear bir animasyona atayalım. Böylece yeniden ölçeklendirme işlemi default oriyantasyon değişim animasyonuyla paralel bir şekilde işleyecek.
            UIView.animateWithDuration(transitionDuration, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                var moviePlayerControllerFrame:CGRect = self.moviePlayerController.view.frame
                moviePlayerControllerFrame.size = newSizeOfTheMoviewPlayerFrame
                self.moviePlayerController.view.frame = moviePlayerControllerFrame
                
                if self.textView != nil {
                    self.textView.frame = CGRectMake(0.0, newSizeOfTheMoviewPlayerFrame.height, destinationScreenSize.width, destinationScreenSize.height - newSizeOfTheMoviewPlayerFrame.height)
                }
                
                }, completion: nil)
            
            
            
            
        }
    }
    
    
    
    //içeriğimizi bu metod içerisinde oluşturuyoruz.
    func createContent() {
        //önce moviePlayer'ı oluşturalım.
        if let movieURL:NSURL = NSURL(string: "http://sample-videos.com/video/mp4/720/big_buck_bunny_720p_10mb.mp4") {
            self.moviePlayerController = MPMoviePlayerController(contentURL: movieURL)
            self.moviePlayerController.prepareToPlay()
            self.moviePlayerController.scalingMode = MPMovieScalingMode.AspectFit
            self.moviePlayerController.view.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 200)
            self.moviePlayerController.movieSourceType = MPMovieSourceType.File
            self.view.addSubview(self.moviePlayerController.view)
            //moviePlayer için bir notification state notification'ı set ediyoruz. Bu sayede video dosyası alındığında ve oynatılmaya başlamadan önce alınan video'nu ölçülerine göre moviePlayer'ın ölçüleri ayarlanabilsin.
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "didMovieLoadStateChange", name: MPMoviePlayerLoadStateDidChangeNotification , object: nil)

            //ve textView'imizi initiate ediyoruz.
            var fontSize:CGFloat = self.view.frame.size.width * 0.04
            self.textView = UITextView(frame: CGRectMake(0.0, self.moviePlayerController.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - 200))
            self.textView.scrollEnabled = true
            self.textView.userInteractionEnabled = true
            self.textView.backgroundColor = UIColor.clearColor()
            self.textView.font = UIFont(name: "Avenir-Heavy", size: fontSize)
            self.textView.textColor = UIColor.blackColor()
            self.textView.textAlignment = NSTextAlignment.Justified
            self.textView.editable = false
            self.textView.text = self.dummyText
            self.view.insertSubview(self.textView, belowSubview: self.moviePlayerController.view)
        }
    }
    
    
    func didMovieLoadStateChange() {
        //movieplayer video dosyasını yükleyip çalışmaya ilk defa başladığı anda updateContent metodumuzu bir kere herhangi bir oryantasyon değişikliği olmadan çağırıyoruz ki
        //alınan video'nun ölçülerine göre moviePlayerController view'imiz boyutlarını videonun boyutlarına göre ayarlanabilsin.
        var targetSize:CGSize = getTargetSizeAccordingToTheTargetOrientation(UIApplication.sharedApplication().statusBarOrientation)
        switch (self.moviePlayerController.loadState) {
        case MPMovieLoadState.Stalled:
            println("Stalled")
        case MPMovieLoadState.Unknown:
            println("Unknown")
        case MPMovieLoadState.PlaythroughOK:
            println("PlaythroughOK")
            //IOS8 ve sonrasında video oynatılmaya hazır hale geldiğinde bu state çağrılıyor.
            updateContent(targetSize, transitionDuration: 0.0)
        case MPMovieLoadState.Playable:
            println("Playable")
            //IOS8 ve öncesinde video oynatılmaya hazır hale geldiğinde bu state çağrılıyor.
            updateContent(targetSize, transitionDuration: 0.0)
        case MPMovieLoadState.allZeros:
            println("allZeros")
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


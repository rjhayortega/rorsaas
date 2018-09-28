
// GALERY
var IsMobile = /Mobi/i.test(navigator.userAgent);
IsMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
if (IsMobile) document.querySelector('html').classList.add('mobile');

$(document).on('ready', initPhotos);
function initPhotos() {
    window.PhotoImageSourceList = JSON.parse(document.querySelector('#photosData').value);
    window.FloorplanImageSourceList = JSON.parse(document.querySelector('#floorplansData').value);
}


//window.addEventListener('load', preloadImages);
function preloadImages()
{
    var a = PhotoImageSourceList.concat(FloorplanImageSourceList);

    function preloadImageSource(s, fn) {
        setTimeout(function(){
            var i = new Image();
            if (fn) i.onload = fn;
            i.src = s;
        }, 0);
    }

    for (var i = 0, src; src = a[i++];) {

        preloadImageSource(src.xsmall);
        preloadImageSource(src.small);
        preloadImageSource(src.medium);
        preloadImageSource(src.large);
        preloadImageSource(src.xlarge);

    }
}


function debounce(func, wait, immediate, context) {
    var timeout;
    return function () {
        var args = arguments;
        context = context || this;
        var later = function () {
            timeout = null;
            if (!immediate) func.apply(context, args);
        };
        var callNow = immediate && !timeout;
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
        if (callNow) func.apply(context, args);
    };
}


// SLick
var heroGallery = function()
{
    var el = {};

    $(document).on('ready', initialize);

    function initialize()
    {
        el.gallery = $("#gallery");
        el.galleryPrev = $("#gallery-prev");
        el.galleryNext = $("#gallery-next");
        el.galleryItemTemplate = el.gallery.find('> div.item-gallery.template');
        el.galleryItemTemplate.remove();


        // init slick shit
        el.gallery.slick({
            speed: 200,
            dots: true,
            infinite: true,
            // autoplay: true,
            autoplaySpeed: 5000,
            // lazyLoad: 'ondemand',
            prevArrow: "<button id='gallery-arrow-prev'><i class='fa fa-angle-left'></i></button>",
            nextArrow: "<button id='gallery-arrow-next'><i class='fa fa-angle-right'></i></button>"
        });

        el.gallery.on('click', 'div.item-gallery', function () {
            var imgIndex = el.gallery.slick('slickCurrentSlide');
            fullGallery.open(imgIndex);
            thumbGallery.show();

        });

        el.gallery.on('afterChange', function (ev, slick, currentSlide) {
            // PageTrack.log(6);
        });

    }

    //add the rest of the hero images after DOM is finished loading.
    //we started adding from index 1 because we already loaded the first item from HTML.
    $(window).on('load', function()
    {
        for (var i = 1, srcItem; srcItem = PhotoImageSourceList[i++];) {
            var item = el.galleryItemTemplate.clone();
            item.find('source.itemGalleryImgSource-xlarge').attr('srcset', srcItem.xlarge);
            item.find('source.itemGalleryImgSource-large').attr('srcset', srcItem.large);
            item.find('source.itemGalleryImgSource-medium').attr('srcset', srcItem.medium);
            item.find('source.itemGalleryImgSource-small').attr('srcset', srcItem.small);
            item.find('source.itemGalleryImgSource-xsmall').attr('srcset', srcItem.xsmall);
            item.find('img.itemGalleryImgSource-default').on('load', function () { $(this).addClass('imgSmoothLoaded'); });
            el.gallery.slick('slickAdd', item);
        }
    });

}();


// GALERY
var fullGallery = function ()
{
    $(document).on('ready', initialize);

    var el = {};
    var psgallery;
    var items = [];
    var imgSizeToUse;


    function initPhotoswipeImages() {

        var a = PhotoImageSourceList.concat(FloorplanImageSourceList);

        for (var i = 0, src; src = a[i++];) {
            items.push({
                xsmall: {
                    src: src.xsmall
                },
                small: {
                    src: src.small
                },
                medium: {
                    src: src.medium
                },
                large: {
                    src: src.large
                },
                xlarge: {
                    src: src.xlarge
                }
            });
        }
    }

    function getImageSize() {
        var width = window.innerWidth;

        if (width < 480)
            return 'small';
        else if (width < 768)
            return 'medium';
        else if (width < 992)
            return 'large';
        else
            return 'xlarge';
    }



    function initialize()
    {
        initPhotoswipeImages();

        el.html = document.querySelector('html');
        el.psDiv = document.querySelector('#fullGallery_Photoswipe');
        el.psElement = el.psDiv.querySelector('.pswp');


        $('[data-showfullgallery-index]').on('click', function ()
        {
            var i = this.getAttribute('data-showfullgallery-index') || 0;
            openFullGallery(+i);
        });

    }


    function openPhotoSwipe(index) {
        var options = {
            index: index,
            closeOnScroll: false,
            closeOnVerticalDrag: IsMobile,
            history: false,
            preload: [1, 1],
            showHideOpacity: true
        };

        psgallery = new PhotoSwipe(el.psElement, PhotoSwipeUI_Default, items, options);

        // after init, so gallery does not close when clicked around
        psgallery.options.closeElClasses = [];
        psgallery.options.clickToCloseNonZoomable = false;


        psgallery.listen('beforeResize', function () {
            var imgSize = getImageSize();
            if (imgSizeToUse != imgSize) {
                imgSizeToUse = imgSize;
                psgallery.invalidateCurrItems();
            }
        });


        psgallery.listen('gettingData', function (index, item)
        {
            var s = item[imgSizeToUse];

            if (s.hasSize) {
                item.src = s.src;
                item.w = s.w;
                item.h = s.h;
            }
            else if (!s.hasInit) {
                item.src = '//propertyshowcase.com/Content/Property/11/img/dotsdark64x16.gif';
                item.w = 64;
                item.h = 16;

                s.hasInit = true;
                var img = new Image();
                img.onload = function () {
                    s.hasSize = true;
                    item.w = s.w = img.naturalWidth;
                    item.h = s.h = img.naturalHeight;
                    psgallery.invalidateCurrItems();
                    psgallery.updateSize(true);
                }
                img.src = s.src;
            }
        });


        // After gallery is closed and closing animation finished.
        // Clean up your stuff here.
        psgallery.listen('close', function () {
            closeFullGallery();
            // PageTrack.log(18); //Click - Close Gallery
        });


        psgallery.listen('afterChange', function () {
            thumbGallery.gotoIndex(psgallery.getCurrentIndex());
            // PageTrack.log(6); //Click - Photo Changed/Viewed
        });


        psgallery.init();

    }

    function openFullGallery(imgIndex)
    {
        el.html.classList.add('showGalleryFullscreen');

        thumbGallery.open();

        openPhotoSwipe(imgIndex || 0);
    }

    function closeFullGallery() {
        el.html.classList.remove('showGalleryFullscreen');
    }


    function psGotoIndex(index) {
        psgallery.goTo(index);
    }


    return {
        open: openFullGallery,
        gotoIndex: psGotoIndex
    };

}();


var thumbGallery = function () {
    var el = {};
    var iScroll;
    var initDone = false;

    function openThumbs() {
        if (!initDone) {
            initThumbs();
            initDone = true;
        }
    }


    function initThumbs() {
        el.gallery = document.querySelector('#thumbGalleryDiv');
        el.itemList = el.gallery.querySelector('ul');
        el.itemTemplate = el.itemList.querySelector('.thumbGalleryItem');
        $(el.itemTemplate).remove();

        var list = PhotoImageSourceList.concat(FloorplanImageSourceList);
        for (var i = 0, src; src = list[i]; i++) {
            var item = el.itemTemplate.cloneNode(true);
            item.setAttribute('data-thumbsgalleryindex', i);
            item.style.backgroundImage = 'url(' + src.thumb + ')';
            el.itemList.appendChild(item);
        }


        $(el.gallery).on('click tap', '.thumbGalleryItem', function () {
            // prefix (+) plus-sign to convert to integer
            var i = +this.getAttribute('data-thumbsgalleryindex');
            fullGallery.gotoIndex(i);
            selectCurrent(i);
        });


        iScroll = new IScroll(el.gallery, {
            scrollX: true,
            scrollY: false,
            mouseWheel: true,
            snap: 'li',
            tap: true
        });

        window.addEventListener('resize', debounce(function(){
            iScroll.refresh();
        }, 200));
    }


    function preloadImageSource(s, fn) {
        var i = new Image();
        i.onload = fn;
        i.src = s;
    }


    function gotoThumbIndex(i) {
        iScroll.goToPage(i, 0, 1000);
        selectCurrent(i);
    }


    function selectCurrent(i) {
        $('.thumbGalleryItem').removeClass('thumbGalleryCurrent');
        $('.thumbGalleryItem[data-thumbsgalleryindex=' + i + ']').addClass('thumbGalleryCurrent');
    }

    function hideThumbs() {
        el.gallery = document.querySelector('#thumbGalleryDiv');
        el.itemList = el.gallery.querySelector('ul');
        el.itemTemplate = el.itemList.querySelector('.thumbGalleryItem');
        el.gallery.classList.remove("showthumbnails");
        el.gallery.classList.add("hidethumbnails");
    }

    function showThumbs() {
        el.gallery = document.querySelector('#thumbGalleryDiv');
        el.itemList = el.gallery.querySelector('ul');
        el.itemTemplate = el.itemList.querySelector('.thumbGalleryItem');
        el.gallery.classList.remove("hidethumbnails");
        el.gallery.classList.add("showthumbnails");
    }



    return {
        open: openThumbs,
        gotoIndex: gotoThumbIndex,
        close: hideThumbs,
        show: showThumbs
    };


}();

// start 3dvid
var opendvideo_3d = function () {
    $(document).on('ready', initialize);

    var el = {};
    var video3d;
    var items = [];
    var video3dIframe;

    function initialize() {
        el.html = document.querySelector('html');
        el.psDiv = document.querySelector('#threeD_vid_Photoswipe');
        el.psElement = el.psDiv.querySelector('.pswp');

        $('[data-video-url]').on('click', function () {
            var videoUrl = this.getAttribute('data-video-url');

            items.push({
                video3dIframe: {
                    html: '<iframe id="video3d-iframe" src="' + videoUrl + '" frameborder="0" allowscriptaccess="always" allowfullscreen></iframe></div>'
                }
            });
            thumbGallery.close();
            openvid3d();
        });
    }


    function openPhotoSwipe(index) {
        var options = {
            index: index,
            closeOnScroll: false,
            closeOnVerticalDrag: IsMobile,
            history: false,
            preload: [2, 2],
            showHideOpacity: true
        };

        video3d = new PhotoSwipe(el.psElement, PhotoSwipeUI_Default, items, options);

        // after init, so gallery does not close when clicked around
        video3d.options.closeElClasses = [];
        video3d.options.clickToCloseNonZoomable = false;

        video3d.listen('gettingData', function (index, item) {
            item.html = (item.video3dIframe.html);
        });

        // After gallery is closed and closing animation finished.
        // Clean up your stuff here.
        video3d.listen('close', function () {
            closevid3d();
        });
        video3d.init();
    }

    function openvid3d(imgIndex) {

        el.html.classList.add('showGalleryFullscreen');
        openPhotoSwipe(imgIndex || 0);

    }

    function closevid3d() {

        el.html.classList.remove('showGalleryFullscreen');
        $('#video3d-iframe')[0].contentWindow.postMessage('{"event":"command","func":"' + 'stopVideo' + '","args":""}', '*');
    }


    function psGotoIndex(index) {
        psgallery.goTo(index);
    }


    return {
        open: openvid3d,
        gotoIndex: psGotoIndex
    };

}();

// start diakrit GALERY
var opendiakrit = function () {
    $(document).on('ready', initialize);

    var el = {};
    var diakritgallery;
    var items = [];

    function initialize() {
        el.html = document.querySelector('html');
        el.psDiv = document.querySelector('#diakritGallery_Photoswipe');
        el.psElement = el.psDiv.querySelector('.pswp');

        $('[data-diakrit-url]').on('click', function () {
            var diakritUrl = this.getAttribute('data-diakrit-url');

            items.push({
                diakritIframe: {
                    html: '<iframe id="diakrit-iframe" src="' + diakritUrl + '" frameborder="0" allowfullscreen></iframe></div>'
                }
            });

            thumbGallery.close();
            openDiakritGallery();
        });
    }


    function openPhotoSwipe(index) {
        var options = {
            index: index,
            closeOnScroll: false,
            closeOnVerticalDrag: IsMobile,
            history: false,
            preload: [2, 2],
            showHideOpacity: true
        };

        diakritgallery = new PhotoSwipe(el.psElement, PhotoSwipeUI_Default, items, options);

        // after init, so gallery does not close when clicked around
        diakritgallery.options.closeElClasses = [];
        diakritgallery.options.clickToCloseNonZoomable = false;

        diakritgallery.listen('gettingData', function (index, item) {
            item.html = (item.diakritIframe.html);
        });

        // After gallery is closed and closing animation finished.
        // Clean up your stuff here.
        diakritgallery.listen('close', function () {
            closeDiakritGallery();
        });

        diakritgallery.init();
    }

    function openDiakritGallery(imgIndex) {
        el.html.classList.add('showGalleryFullscreen');
        openPhotoSwipe(imgIndex || 0);
    }

    function closeDiakritGallery() {
        el.html.classList.remove('showGalleryFullscreen');
    }

    function psGotoIndex(index) {
        psgallery.goTo(index);
    }

    return {
        open: openDiakritGallery,
        gotoIndex: psGotoIndex
    };

}();

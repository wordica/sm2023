
$(window).on("load", function() {

    infinite_scroll();
    scroll_top();
    random_tags_top_font_size();
});



function random_tags_top_font_size(){

    jQuery('.most_popular_tags_column .tag').each( function(){
        var r_f = Math.floor(Math.random()*12 + 12)
        jQuery(this).css('font-size',r_f)
    })

}

function infinite_scroll(){

    var $grid = $('.main_page_isotope_column').isotope({

        itemSelector: 'none', // select none at first
        masonry: {
            columnWidth: 440,
            isFitWidth: true,
            gutter: 4
        },
        stagger: 50,
        
    });
  
 
    $grid.imagesLoaded( function() {
    
        $grid.isotope( 'option', { itemSelector: '.iso_image' });
        var $items = $grid.find('.iso_image');
        $grid.isotope( 'appended', $items );
        $grid.isotope('layout');
        
    });
  
    var iso = $grid.data('isotope');

   
    
    $grid.infiniteScroll({
        path: '.pagination a[rel="next"]',
        scrollThreshold: 400,
        append: '.iso_image',
        outlayer: iso
    });

}


function scroll_top(){

    'use strict';
  
    jQuery('.right_top_scroll').on('click','',function(){
  
      jQuery('html,body').animate({ scrollTop: "0px" });
  
    });
  
}

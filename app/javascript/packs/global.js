
$(window).on("load", function() {

    infinite_scroll();
    scroll_top();
    random_tags_top_font_size();
   
    photo_hover();
    modal_open();
    copy_to_clipboard_first();
    
    init_tooltipster();

    modal_download_ajax();

    fancybox_related_photos();

});


function fancybox_related_photos(){

    jQuery('.modal .related_photo .photo').each( function(){

        jQuery(this).find('a.fancybox').fancybox({

            beforeLoad : function(){
                
                jQuery('body').removeClass('fancybox-active').removeClass('compensate-for-scrollbar');
                
            },
            beforeClose : function(){
                
            }

        });

    });

}




function modal_download_ajax(){


    jQuery('.modal-footer .btn_download').on('click',function(){
        var p_id =  jQuery(this).data('id')
        console.log(p_id)
        jQuery.ajax({
            type: 'POST',
            data: { p_id_data: p_id },
            url: '/photos/download_photo',
            success: function(data){
               
            }


        });

    });

    jQuery('.icon_to_download').on('click',function(){
        var p_id =  jQuery(this).data('id')
        console.log(p_id)
        jQuery.ajax({
            type: 'POST',
            data: { p_id_data: p_id },
            url: '/photos/download_photo',
            success: function(data){
               
            }


        });

    });


    

}

function init_tooltipster(){

    jQuery('.tooltips').tooltip();
     
}


function modal_open(){

    jQuery('.main_page_isotope_column .iso_image').each( function(){

        jQuery(this).on('click', function(){

             jQuery(this).find('.modal').modal('show');
             copy_to_clipboard();
             
         });
        

    });


}


function generate_04(type,text) {

	var n = noty({
        text: text,
        type: type,
        timeout : 4000,
        dismissQueue: true,
        maxVisible: 6,
        layout: 'topRight',
        theme: 'defaultTheme'

	});

}

function generate_noty(){

	jQuery( ".messages_notify #message-add_like" ).each( function(){
		generate_04('error', 'Photo Liked. You can only like it once.');
	});

}


function photo_hover(){

    jQuery('.main_page_isotope_column .iso_image').each( function(){

        jQuery(this).on('mouseover', function(){
            jQuery(this).find('.photo_hidden_container').css('display','block').css('opacity','1').css('cursor','zoom-in');
            
        });
        
        jQuery(this).on('mouseout', function(){
            jQuery(this).find('.photo_hidden_container').css('display','none').css('opacity','0');
            
        });
       
    })
    
}


function random_tags_top_font_size(){

    jQuery('.most_popular_tags_column .tag').each( function(){

        var r_f = Math.floor(Math.random()*12 + 12);
        jQuery(this).css('font-size',r_f);

    })

}


function copy_to_clipboard_first(){

   
    jQuery('.profile_attribute').on("click", function(event){

        event.preventDefault();
        value = jQuery(this).data('clipboardtext');
        navigator.clipboard.writeText(value);
        generate_04('error', 'Copied to ClipBoard');
        
    });

}


function copy_to_clipboard(element){

    var item = element;

    jQuery(item).find('.profile_attribute').on("click", function(event){

        event.preventDefault();
        value = jQuery(this).data('clipboardtext');
        navigator.clipboard.writeText(value);
        generate_04('error', 'Copied to ClipBoard');
        
    });

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
        scrollThreshold: 1400,
        append: '.iso_image',
        outlayer: iso
    });

    $grid.on( 'load.infiniteScroll', function() {

        
        
    });

    $grid.on( 'append.infiniteScroll', function(event, body, path, items, response) {
        
        jQuery('.main_page_isotope_column .iso_image').each( function(){

            jQuery(this).off('click');
            jQuery(this).find('.profile_attribute').off('click');

        });

        

        jQuery('.main_page_isotope_column .iso_image').each( function(){

            jQuery(this).on('mouseover', function(){
                jQuery(this).find('.photo_hidden_container').css('display','block').css('opacity','1').css('cursor','zoom-in');
                
            });
            
            jQuery(this).on('mouseout', function(){
                jQuery(this).find('.photo_hidden_container').css('display','none').css('opacity','0');
                
            });

            jQuery(this).on('click', function(){

                jQuery(this).find('.modal').on("hidden.bs.modal", function () { 

                    jQuery('.main_page_isotope_column .iso_image').each( function(){

                        jQuery(this).find('.profile_attribute').off('click');

                    });

                });

                jQuery(this).find('.modal').modal('show');
                copy_to_clipboard(this);
                init_tooltipster();
                fancybox_related_photos();
             });
            

        });

        
        
        
    });
}








function scroll_top(){

    'use strict';
  
    jQuery('.right_top_scroll').on('click','',function(){
  
      jQuery('html,body').animate({ scrollTop: "0px" });
  
    });
  
}

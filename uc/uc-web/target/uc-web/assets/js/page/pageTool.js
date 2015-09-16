/**
 * 分页插件
 * @auth:chengjinman
 */
(function ($) {
    function PageToolObj(opt) {
        this.defaults = {
            divClass: "paging clearfix",
            totalPages: 1,// 总的页数
            total: 1,// 总记录数
            fetchSize: 10, // 每页显示的记录数
            maxNum: 5,// 最多显示几个数字，如：1,2,3，...,6 ; 1,2,3,4,5
            activeIndex: 1,// 当前活动页
            maxBuChang: 10,// 最大步长
            getPage: function (active, fetchSize) {
            },// 点击分页按钮时触发，active 当前页。fetchSize 每页记录数
            pageTool: ""// 分页对象
        };
        this.options = jQuery.extend({}, this.defaults, opt);
        this.options.totalPages = this.getTotalPages(this.options.total, this.options.fetchSize);
    }

    PageToolObj.prototype = {
        getToolPart: function (i, active, index) {
            var result = "";
            if (i == active) {
                result = '<a class="active-btn-paging" href="#" index="' + index + '">' + index + '</a> ';
            } else {
                result = '<a href="#" index="' + index + '">' + index + '</a> ';
            }
            return result;
        },
        getTotalPages: function (total, fetchSize) {
            var num = parseInt(total / fetchSize);
            var mod = total % fetchSize;
            if (mod > 0) {
                num = num + 1;
            }
            return num;
        }
    }

    $.fn.pageTool = function (options) {
        var $this = this;
        $(this).empty();
        $(this).css("border","0px");

        var tool = $(this).data("pageTool");
        if (tool == null) {
            tool = new PageToolObj(options);
            $(this).data("pageTool", tool);
        } else {
            tool.options = jQuery.extend({}, tool.options, options);
            tool.options.totalPages = tool.getTotalPages(tool.options.total, tool.options.fetchSize);
        }
        tool.options.pageTool = tool;
        var setting = tool.options;

        this.attr("class", setting.divClass);
        var div2 = jQuery("<div class='pull-right info-paging'></div>");

        div2.css( "padding", "10px 0px");

        var wordPart = jQuery("<div class='pull-left'></div>");
        var menuPart = jQuery("<div class='pull-left ml-20'></div>");

        var gongChinese = jQuery("<span></span>");
        gongChinese.text("共  ");

        // 总记录数字部分
        var totalPart = jQuery("<span class='text-primary'></span>");
        totalPart.html(setting.total);
        // 条，每页显示   部分
        var otherChinese = jQuery("<span></span>");
        otherChinese.text("  条，每页显示  ");
        // 每页显示记录数字
        var fetchSizePart = jQuery("<span class='text-primary'></span>");
        fetchSizePart.text(setting.fetchSize);
        // 条  字部分
        var tiaoChinese = jQuery("<span></span>");
        tiaoChinese.text("  条");

        wordPart.append(gongChinese);
        wordPart.append(totalPart);
        wordPart.append(otherChinese);
        wordPart.append(fetchSizePart);
        wordPart.append(tiaoChinese);
        // 活动页
        var active = setting.activeIndex;
        var fetchSize = setting.fetchSize;

        // 最前面的箭头
        menuPart.append('<a class="prev-btn-paging" href="javascript:;"></a>');

        if(setting.totalPages <= 0) {
            menuPart.append('<a href="javascript:;" class="active-btn-paging" index="1">1</a> ');
        }
        var index = 1;
        for (var i = 1; i <= setting.maxNum && active <= setting.totalPages && i <= setting.totalPages; i++) {
            // 当前活动页前面和后面最多有两个数字
            if (i == 1) {
                menuPart.append(tool.getToolPart(i, active, 1));
            } else if (i == 2 && setting.totalPages > setting.maxNum && active >= 4) {// 大于5页，且活动页大于 3页
                menuPart.append('<a href="javascript:;" class="shenglue">...</a> ');
                if (active == setting.totalPages - 1) {// 大于5页，且为倒数第二页
                    index = active - 2;
                } else if (active == setting.totalPages) {// 大于5页，且为倒数第一页
                    index = active - 3;
                } else {
                    index = active - 1;
                }
                menuPart.append('<a href="javascript:;" index="' + index + '">' + index + '</a> ');
            } else if (i == 2 && active <= 5) {
                menuPart.append(tool.getToolPart(i, active, 2));
            } else if (i == 3) {
                if (active > 3 && active <= setting.totalPages - 2) {// 第3页 到 倒数第二页之间
                    index = active;
                } else if (active > 3 && active == setting.totalPages - 1) {// 多于 3页时，且为 倒数第2页
                    index = active - 1;
                } else if (active > 3 && active == setting.totalPages && setting.totalPages != 4) {// 多于 3 页时，且为 倒数第1 页
                    index = setting.totalPages - 2;
                } else if (active <= 3) {// 第1、2、3 页时
                    index = 3;
                } else if (active == 4 && setting.totalPages == 4) {
                    index = 3;
                }
                if (active > 3 && active <= setting.totalPages - 2) {// 一直是当前页
                    menuPart.append('<a class="active-btn-paging" href="javascript:;" index="' + index + '">' + index + '</a> ');
                } else {
                    menuPart.append(tool.getToolPart(i, active, index));
                }
            } else if (i == 4 && (active + 2) < setting.totalPages && setting.maxNum < setting.totalPages) {
                //多余5页，且不是倒数第1页和倒数第2页
                if (active > 3) {// 活动页大于3页且 不是倒数第1页和倒数第2页
                    index = active + 1;
                } else {// 活动页小于等于3页
                    index = 4;
                }
                if (active > 3) {
                    menuPart.append('<a href="javascript:;" index="' + index + '">' + index + '</a>');
                } else {
                    menuPart.append(tool.getToolPart(i, active, index));
                }
                menuPart.append('<a href="javascript:;" class="shenglue">...</a> ');
            } else if (i == 4 && ((active + 2) >= setting.totalPages || setting.maxNum >= setting.totalPages)) {
                // 是倒数第1页和倒数第2页，或者总页数少于 5页
                if (active + 1 == setting.totalPages && setting.totalPages > setting.maxNum) {// 倒数第2 页
                    index = active;
                } else if (active == setting.totalPages && setting.totalPages > setting.maxNum) {// 倒数第1页
                    index = active - 1;
                } else if (active + 2 == setting.totalPages && setting.totalPages > setting.maxNum) {// 倒数第3页，且总页数大于5页
                    index = active + 1;
                } else if (setting.totalPages <= setting.maxNum) {// 总页数为 4或5 页，活动页第1 页
                    index = 4;
                }
                if (setting.totalPages > setting.maxNum) {
                    menuPart.append(tool.getToolPart(setting.totalPages, active + 1, index));
                } else {
                    menuPart.append(tool.getToolPart(i, active, index));
                }
            } else if (i == 5) {
                index = setting.totalPages;
                menuPart.append(tool.getToolPart(active, setting.totalPages, index));
            }
        }
        // 最后面的箭头
        menuPart.append('<a class="next-btn-paging" href="javascript:;"></a>');

        menuPart.find("a").bind("click", function () {
            var pageIndex = Number($(this).attr("index"));
            //tool.options.pageTool.activeIndex = pageIndex;
            setting.getPage(pageIndex, fetchSize);
            setting.activeIndex = pageIndex;
            $($this).pageTool(setting);
        });
        menuPart.find("a[class='prev-btn-paging']").unbind("click");
        menuPart.find("a[class='prev-btn-paging']").bind("click", function () {
            if (setting.activeIndex > 1) {
                setting.getPage(setting.activeIndex - 1, fetchSize);
                setting.activeIndex = setting.activeIndex - 1;
                $($this).pageTool(setting);
            }
        });
        menuPart.find("a[class='next-btn-paging']").unbind("click");
        menuPart.find("a[class='next-btn-paging']").bind("click", function () {
            if (setting.activeIndex < setting.totalPages) {
                setting.getPage(setting.activeIndex + 1, fetchSize);
                setting.activeIndex = setting.activeIndex + 1;
                $($this).pageTool(setting);
            }
        });
        menuPart.find("a[class='shenglue']").unbind("click");
        div2.append(wordPart);
        div2.append(menuPart);
        this.append(div2);
        return tool;
    };
})(jQuery);

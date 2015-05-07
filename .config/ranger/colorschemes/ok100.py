# https://github.com/ok100/dotfiles/blob/master/config/ranger/colorschemes/ok100.py


from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class Default(ColorScheme):
    progress_bar_color = 0

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            attr = reverse if context.selected else normal
            if context.empty or context.error:
                attr = bold
                fg = red
            if context.image:
                fg = yellow
            if context.video:
                fg = magenta
            if context.audio:
                fg = blue
            if context.document:
                fg = green
            if context.container:
                fg = 9
            if context.directory:
                attr |= bold
                fg = white
            elif context.executable and not \
                    any((context.media, context.container,
                        context.fifo, context.socket)):
                fg = green
                attr |= bold
            if context.socket:
                fg = magenta
                attr |= bold
            if context.fifo or context.device:
                fg = blue
                attr |= bold
            if context.link:
                attr |= bold
                fg = context.good and cyan or red
            if context.tag_marker and not context.selected:
                attr |= bold
                fg = yellow
            if not context.selected and (context.cut or context.copied):
                bg = 8
                #attr |= bold
            if context.main_column and context.marked:
                    attr |= bold
                    fg = 11
            if context.badinfo:
                if attr & reverse:
                    bg = magenta
                else:
                    fg = magenta
            if context.border:
                fg = default

        elif context.in_titlebar:
            if context.hostname:
                fg = context.bad and red or white
            elif context.directory:
                fg = 7
            elif context.tab:
                if context.good:
                    attr |= reverse
            elif context.link:
                fg = cyan

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = white
                elif context.bad:
                    fg = red
            if context.marked:
                attr |= bold | reverse
                fg = yellow
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = red
            if context.loaded:
                bg = self.progress_bar_color

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = default
                attr |= bold

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                    bg = white
                else:
                    bg = self.progress_bar_color
                    fg = white

        return fg, bg, attr

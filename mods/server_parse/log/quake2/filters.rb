module Uvula
  module Q2Log
    SKIP_LIST =
      /
	nail|
	mnh(.*)

 /

    CHAT_HILITE =
      / (
      console |
      admin|
      (aim\s*|\b)BOT(\b|s|ter|ting|er|ing)? |
      \bcheat\w* |
      \bha(ck\w*|x\w*) |
      \bwall(ed|ing|\s*ha[cx]\w*)
    )
  /ix.freeze

    CHAT_FILTER = / \A(\(.*?\))?\(private message\) |
                        YO!.+INVITES YOU TO GOTO |
                        Sorry guys, I'm a lamer and I talk too much. |
                        Please report any bugs at www.opentdm.net. |
                        p_auth q2acedetect |
                        scr_centertime

                       /x.freeze

    CHAT_FILTER_TWO =
      /
    \A.*?:\s*(bg+|goto|mymap)\s*\??\s*\z |
    Warmup\s+mode\s+over\.\s+Ready\s+up |
    \d+\s+players\s+not\s+ready |
    Voting\s+now\s+disabled
  /ix


  end
end
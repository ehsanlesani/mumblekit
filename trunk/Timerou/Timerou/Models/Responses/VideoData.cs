﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Responses
{
    public class VideoData
    {
        public static VideoData FromVideo(Video video)
        {
            VideoData data = new VideoData()
            {
                YoutubeId = video.YoutubeId
            };

            return data;
        }

        public string YoutubeId { get; set; }
    }
}

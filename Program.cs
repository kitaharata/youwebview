using System;
using System.Collections.Generic;
using System.IO;
using System.Windows;
using System.Windows.Markup;

using Microsoft.Web.WebView2.Core;
using Microsoft.Web.WebView2.Wpf;

namespace WpfApp
{
    class Program
    {
        [STAThread]
        static void Main(string[] args)
        {
            Window w = null;
            using (var fs = new FileStream("MainWindow.xaml", FileMode.Open, FileAccess.Read, FileShare.None))
            {
                w = (Window)XamlReader.Load(fs);
            }

            var rand = new Random();
            var v = new List<string>
            {
                "syGJ0gAEXwQ",
                "b0kSQ-nSFQE",
                "xruJjg7dhkQ",
                "e9fTnzx7wzY",
                "8Zc_XsN-pkU",
                "OiCqjPoPg4E"
            };

            var webViewer = (WebView2)w.FindName("WebViewer");
            webViewer.CreationProperties = new CoreWebView2CreationProperties();
            webViewer.CreationProperties.UserDataFolder = Path.GetTempPath() + "WebView2";
            if (args.Length == 0)
                webViewer.Source = new Uri(@"https://www.youtube.com/embed/" + v[rand.Next(v.Count)]);
            else
                webViewer.Source = new Uri(@"https://www.youtube.com/embed/" + args[0]);

            var app = new Application();
            app.Run(w);
        }
    }
}

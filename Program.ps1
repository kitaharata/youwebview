# PowerShell -ExecutionPolicy RemoteSigned -File Program.ps1

$path = "Microsoft.Web.WebView2.Wpf.dll"

$ref = @(
    "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\System.Xaml.dll"
    "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\System.Xml.dll"
    "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\WPF\PresentationCore.dll"
    "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\WPF\PresentationFramework.dll"
    "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\WPF\WindowsBase.dll"
    "Microsoft.Web.WebView2.Core.dll"
    "Microsoft.Web.WebView2.Wpf.dll"
)

$src = @"
using System;
using System.Collections.Generic;
using System.IO;
using System.Windows;
using System.Windows.Markup;

using Microsoft.Web.WebView2.Core;
using Microsoft.Web.WebView2.Wpf;

namespace WpfApp
{
    public class Program
    {
        [STAThread]
        public static void Main(string[] args)
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
"@

Add-Type -TypeDefinition $src -ReferencedAssemblies $ref
Add-Type -Path $path
if ($Args.Length -eq 0)
{
    [WpfApp.Program]::Main(@())
}
else
{
    [WpfApp.Program]::Main($Args[0])
}

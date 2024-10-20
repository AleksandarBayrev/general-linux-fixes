using System.Diagnostics;

namespace FlatpakInstallScript
{
    public class Program
    {
        public static async Task Main(string[] args)
        {
            var filePath = Path.GetFullPath(Path.Join(Directory.GetCurrentDirectory(), "flatpaks.txt"));

            if (!File.Exists(filePath))
            {
                Console.WriteLine($"{filePath} not found! Create a flatpaks.txt with app name separated with a new line.");
                return;
            }

            var process = new Process();

            process.StartInfo = new ProcessStartInfo($"/usr/bin/cat {filePath} | /usr/bin/xargs /usr/bin/flatpak install")
            {
                UseShellExecute = false,
                RedirectStandardOutput = true,
                RedirectStandardError = true,
            };
            process.Start();
            while (!process.StandardOutput.EndOfStream)
            {
                Console.WriteLine(await process.StandardOutput.ReadLineAsync());
            }
            await process.WaitForExitAsync();
        }
    }
}
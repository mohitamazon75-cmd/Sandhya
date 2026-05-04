import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Sandhya",
  description: "A daily companion in the tradition.",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body>{children}</body>
    </html>
  );
}

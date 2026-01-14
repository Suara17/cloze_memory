import { createFileRoute } from '@tanstack/react-router'

export const Route = createFileRoute('/_layout/dashboard')({
  component: DashboardPage,
})

function DashboardPage() {
  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold mb-6">生产实时看板</h1>
      <div>Dashboard content here</div>
    </div>
  )
}